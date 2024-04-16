//
//  CryptocurrencyDomainMapper.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation

class CryptocurrencyDomainMapper {
    
    func getCryptoCurrencyBuilderList(symbolList: [String], cryptoList: [CryptocurrencyBasicDTO]) -> [CryptocurrencyBuilder] {
        var symbolListDic = [String: Bool]()
        
        symbolList.forEach { symbol in
            symbolListDic[symbol] = true
        }
        
        // filtrar si el símbolo existe en el dictionary de SymbolListDic
        let globalCryptoList = cryptoList.filter { symbolListDic[$0.symbol] ?? false }
        
        print(globalCryptoList)
        // Patrón Builder para construir los objetos de diferentes fuentes
        let cryptocurrencyBuilderList = globalCryptoList.map {
            CryptocurrencyBuilder(id: $0.id, name: $0.name, symbol: $0.symbol)
        }
        
        return cryptocurrencyBuilderList
    }
    
    func map(cryptocurrencyBuilderList: [CryptocurrencyBuilder], priceInfo: [String: CryptocurrencyPriceDTO]) -> [Cryptocurrency] {
        cryptocurrencyBuilderList.forEach { cryptocurrencyBuilderItem in
            // si el ID de la criptomoneda existe en el Dictionary de los precios
            if let priceInfo = priceInfo[cryptocurrencyBuilderItem.id] {
                cryptocurrencyBuilderItem.price = priceInfo.price
                cryptocurrencyBuilderItem.volume24h = priceInfo.volume24h
                cryptocurrencyBuilderItem.marketCap = priceInfo.marketCap
                cryptocurrencyBuilderItem.price24h = priceInfo.price24h
            }
        }
        return cryptocurrencyBuilderList.compactMap { $0.build() }
    }
    
}
