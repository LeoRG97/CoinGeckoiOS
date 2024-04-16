//
//  GlobalCryptoListViewModel.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation
import Combine

class GlobalCryptoListViewModel: ObservableObject {
    
    private let getGlobalCryptoList: GetGlobalCryptoListType
    private let errorMapper: CryptocurrencyPresentableErrorMapper
    
    // variable Published que será monitoreada desde la View
    @Published var cryptos: [CryptoListPresentableItem] = []
    @Published var isLoadingData: Bool = false
    @Published var showErrorMessage: String? = ""
    
    init(GetGlobalCryptoList: GetGlobalCryptoListType, errorMapper: CryptocurrencyPresentableErrorMapper) {
        self.getGlobalCryptoList = GetGlobalCryptoList
        self.errorMapper = errorMapper
    }
    
    func onAppear() {
        // método que será ejecutado cuando la vista aparezca
        self.isLoadingData = true
        Task {
            let result = await getGlobalCryptoList.execute()
            // let cryptocurrencies = try? result.get()
            
            guard case .success(let cryptos) = result else {
                handleError(error: result.failureValue as? CryptocurrencyDomainError)
                return
            }
            
            let presentableCryptos = cryptos.map {CryptoListPresentableItem(domainModel: $0) }

          
            Task { @MainActor in
                // este es el equivalente al "runOnUIThread" de Kotlin
                /*
                guard let cryptocurrencies = presentableCryptos else {
                    return
                }
                 */
                
                self.cryptos = presentableCryptos
                self.isLoadingData = false
            }
        }
    }
    
    
    private func handleError(error: CryptocurrencyDomainError?) {
        
        let message = errorMapper.map(error: error)
        
        Task { @MainActor in
            // obtiene el mensaje de error y lo actualiza en la variable dentro del hilo principal
            self.showErrorMessage = message
            self.isLoadingData = false
            
        }
    }
    
}
