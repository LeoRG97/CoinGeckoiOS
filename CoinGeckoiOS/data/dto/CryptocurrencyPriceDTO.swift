//
//  CryptocurrencyPriceDTO.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 13/04/24.
//

import Foundation

struct CryptocurrencyPriceDTO: Codable {
    
    var price: Double
    var marketCap: Double
    var volume24h: Double
    var price24h: Double
    
    // CodingKeys se usa para mapear las propiedades del JSON con las propiedades del modelo de Swift (ah, ya entendí)
    enum CodingKeys: String, CodingKey {
        case price = "usd"
        case marketCap = "usd_market_cap"
        case volume24h = "usd_24h_vol"
        case price24h = "usd_24h_change"
    }
    
}
