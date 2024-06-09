//
//  APIPriceDataSource.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 26/05/24.
//

import Foundation

class APIPriceDataSource: ApiPriceDataSourceType {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    //https://api.coingecko.com/api/v3/coins/bitcoin/market_chart?vs_currency=usd&days=30&interval=daily
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistoryDTO, HTTPClientError> {
        let queryParams: [String: Any] = [
        
            "vs_currency": "usd",
            "days": days,
            "interval": "daily",
        
        ]
        
        let endpoint = Endpoint(path: "coins/\(id)/market_chart", queryParams: queryParams, method: .GET)
        
        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://api.coingecko.com/api/v3/")
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        guard let priceHistoryDTO = try? JSONDecoder().decode(CryptocurrencyPriceHistoryDTO.self, from: data)
        else {
            return .failure(.parsingError)
        }
        
        return .success(priceHistoryDTO)
        
    }
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .genericError
        }
        return error
    }
    
}
