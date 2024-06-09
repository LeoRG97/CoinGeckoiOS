//
//  GlobalCryptoDetailViewModel.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 09/06/24.
//

import Foundation

class CryptoDetailViewModel: ObservableObject {
    
    @Published var dataPoints: [ChartDataPoint] = []
    @Published var isLoading: Bool = false
    @Published var showErrorMessage: String?
    let getPriceHistory: GetPriceHistoryUseCase
    let errorMapper: CryptocurrencyPresentableErrorMapper
    let cryptocurrency: CryptoListPresentableItem
    
    init(getPriceHistory: GetPriceHistoryUseCase, errorMapper: CryptocurrencyPresentableErrorMapper, cryptocurrency: CryptoListPresentableItem) {
        self.getPriceHistory = getPriceHistory
        self.errorMapper = errorMapper
        self.cryptocurrency = cryptocurrency
    }
    
    func onAppear() {
        showErrorMessage = ""
        isLoading = true
        Task {
            let result = await getPriceHistory.execute(id: cryptocurrency.id, days: 30)
            
            guard case .success(let priceHistory) = result else {
                return handleError(error: result.failureValue as? CryptocurrencyDomainError)
            }
            
            let dataPoints = priceHistory.prices.map { ChartDataPoint(date: $0.date, price: $0.price) }
            Task { @MainActor in
                self.dataPoints = dataPoints
                self.isLoading = false
            }

        }
    }
    
    private func handleError(error: CryptocurrencyDomainError?) {
        
        let message = errorMapper.map(error: error)
        
        Task { @MainActor in
            // obtiene el mensaje de error y lo actualiza en la variable dentro del hilo principal
            self.showErrorMessage = message
            self.isLoading = false
            
        }
    }
    
}
