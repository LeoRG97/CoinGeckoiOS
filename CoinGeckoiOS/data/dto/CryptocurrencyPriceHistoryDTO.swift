//
//  CryptocurrencyPriceHistoryDTO.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 26/05/24.
//

import Foundation

struct CryptocurrencyPriceHistoryDTO: Codable {
    let prices: [[Double]]
    
    enum CodingKeys: String, CodingKey {
        case prices
    }
}
