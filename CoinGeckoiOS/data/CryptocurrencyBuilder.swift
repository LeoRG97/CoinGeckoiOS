//
//  CryptocurrencyBuilder.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation

class CryptocurrencyBuilder {
    
    var id: String
    var name: String
    var symbol: String
    var price: Double?
    var price24h: Double?
    var volume24h: Double?
    var marketCap: Double?
    
    init(id: String, name: String, symbol: String) {
        self.id = id
        self.name = name
        self.symbol = symbol
    }
    
    func build() -> Cryptocurrency? {
        
        // si no se puede crear la criptomoneda, retornar nil
        guard let price = price?.toCurrency(),
              let marketCap = marketCap?.toCurrency() else { return nil }
        
        return Cryptocurrency(
            id: id,
            name: name,
            symbol: symbol,
            price: price,
            price24h: price24h?.toCurrency(),
            volume24h: volume24h?.toCurrency(),
            marketCap: marketCap
        )
    }
    
}
