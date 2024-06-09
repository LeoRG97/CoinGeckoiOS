//
//  GlobalCryptoListFactory.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation

class GlobalCryptoListFactory {
    
    // crea la View (el único que es público para otras clases)
    static func create() -> GlobalCryptoListView {
        return  GlobalCryptoListView(
            viewModel: createViewModel(),
            createCryptoDetailView: CryptoDetailFactory() // inyección del Factory para crear la vista de detalle
        )
    }
    
    // crea el ViewModel
    private static func createViewModel() -> GlobalCryptoListViewModel {
        return GlobalCryptoListViewModel(
            GetGlobalCryptoList: createUseCase(),
            errorMapper: CryptocurrencyPresentableErrorMapper()
        )
    }
    
    // crea el caso de uso con sus dependencias
    private static func createUseCase() -> GetGlobalCryptoListType {
        return GetGlobalCryptoListUseCase(repository: createRepository())
    }
    
    // crea el repositorio con sus dependencias
    private static func createRepository() -> GlobalCryptoListRepositoryType {
        return CryptocurrencyRepository(
            apiDataSource: createDataSource(),
            errorMapper: CryptocurrencyDomainErrorMapper(),
            domainMapper: CryptocurrencyDomainMapper()
        )
        
    }
    
    // crea la Data source con sus dependencias
    private static func createDataSource() -> ApiDataSourceType {
        
        let httpClient = URLSessionHTTPClient(
            requestMaker: URLSessionRequestMaker(), //aquellos que no tienen dependencias se inyectan directamente
            sessionErrorResolver: URLSessionErrorResolver()
        )
        return APICryptoDataSource(httpClient: httpClient)
        
    }
    
}
