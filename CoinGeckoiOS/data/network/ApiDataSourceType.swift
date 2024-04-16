//
//  ApiDataSourceType.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 13/04/24.
//

import Foundation

// interface para inyectar los métodos de la API
protocol ApiDataSourceType {
    
    func getGlobalCryptoSymbolList() async -> Result<[String], HTTPClientError>
    
    func getCryptoList() async -> Result<[CryptocurrencyBasicDTO], HTTPClientError>
    
    // [String: CryptocurrencyPriceDTO] es un Dictionary porque en el JSON hay una clave String que identifica a cada objeto
    func getPriceInfoForCryptos(id: [String]) async -> Result<[String: CryptocurrencyPriceDTO], HTTPClientError>
    
}
