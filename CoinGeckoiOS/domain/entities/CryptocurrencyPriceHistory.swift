//
//  CryptocurrencyPriceHistory.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 26/05/24.
//

import Foundation

struct CryptocurrencyPriceHistory {
    let prices: [DataPoint]
    
    struct DataPoint {
        let price: Double
        let date: Date
    }
}
