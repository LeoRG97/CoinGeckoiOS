//
//  CryptoDetailFactory.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 09/06/24.
//

import Foundation

// implementa la interfaz CreateCryptoDetailView para poder usarla en la vista
class CryptoDetailFactory: CreateCryptoDetailView {
    
    func create(cryptocurrency: CryptoListPresentableItem) -> CryptoDetailView {
        return CryptoDetailView(viewModel: createViewModel(cryptocurrency: cryptocurrency))
    }
    
    private func createViewModel(cryptocurrency: CryptoListPresentableItem) -> CryptoDetailViewModel {
        return CryptoDetailViewModel(getPriceHistory: createUseCase(), errorMapper: CryptocurrencyPresentableErrorMapper(), cryptocurrency: cryptocurrency)
    }
    
    private func createUseCase() -> GetPriceHistoryUseCase {
        return GetPriceHistoryUseCase(repository: createRepository())
    }
    
    private func createRepository() -> CryptocurrencyPriceHistoryRepositoryType {
        return CryptocurrencyPriceRepository(apiDataSource: createApiDataSource(), domainMapper: CryptocurrencyPriceHistoryDomainMapper(), errorMapper: CryptocurrencyDomainErrorMapper())
    }
    
    private func createApiDataSource() -> ApiPriceDataSourceType {
        return APIPriceDataSource(httpClient: createHTTPClient())
    }
    
    private func createHTTPClient() -> HTTPClient {
        return URLSessionHTTPClient(requestMaker: URLSessionRequestMaker(), sessionErrorResolver: URLSessionErrorResolver())
    }
    
}
