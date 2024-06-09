//
//  APICryptoDataSource.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation


class APICryptoDataSource: ApiDataSourceType {
    
    private let httpClient: HTTPClient
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }
    
    //https://api.coingecko.com/api/v3/global
    func getGlobalCryptoSymbolList() async -> Result<[String], HTTPClientError> {
        let endpoint = Endpoint(path: "global", queryParams: [:], method: .GET)
        
        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://api.coingecko.com/api/v3/")
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        guard let symbolList = try? JSONDecoder().decode(CryptocurrencyGlobalInfoDTO.self, from: data) else {
            return .failure(.parsingError)
        }
        
        
        // lo que se requiere es devolver un array de keys nada más
        return .success(symbolList.data.cryptocurrencies.map { $0.key })
        
        
    }
    
    //https://api.coingecko.com/api/v3/coins/list
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError> {
    
        let endpoint = Endpoint(path: "coins/list", queryParams: [:], method: .GET)
        
        let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://api.coingecko.com/api/v3/")
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        // decode lleva un array porque se espera recuperar la información como un Array de CryptocurrencyBasicDTO
        guard let cryptoList = try? JSONDecoder().decode([CryptocurrencyBasicDTO].self, from: data) else {
            return .failure(.parsingError)
        }
        
        return .success(cryptoList)
        
    }
    
    //https://api.coingecko.com/api/v3/simple/price?ids=3&vs_currencies=2
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String : CryptocurrencyPriceDTO], HTTPClientError> {
        // cuando una request requiere queryParams, se pueden definir en un Dictionary
        let queryParams = [
            "ids": id.joined(separator: ","), // convierte un array a un String con los valores separados por un caracter
            "vs_currencies": "usd",
            "include_market_cap": true,
            "include_24hr_vol": true,
            "include_24hr_change": true
        ] as [String : Any]
        
        let endpoint = Endpoint(
            path: "simple/price",
            queryParams: queryParams,
            method: .GET
        )
        
       let result = await httpClient.makeRequest(endpoint: endpoint, baseUrl: "https://api.coingecko.com/api/v3/")
        
        guard case .success(let data) = result else {
            return .failure(handleError(error: result.failureValue as? HTTPClientError))
        }
        
        // decode lleva un array porque se espera recuperar la información como un Array de CryptocurrencyBasicDTO
        guard let cryptoList = try? JSONDecoder().decode([String : CryptocurrencyPriceDTO].self, from: data) else {
            return .failure(.parsingError)
        }
        
        return .success(cryptoList)
        
    }
    
    private func handleError(error: HTTPClientError?) -> HTTPClientError {
        guard let error = error else {
            return .genericError
        }
        return error
    }
    
    
}




