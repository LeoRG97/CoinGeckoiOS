//
//  Cryptocurrency.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 13/04/24.
//

import Foundation

struct Cryptocurrency {
    
    var id: String
    var name: String
    var symbol: String
    var price: Double
    var price24h: Double?
    var volume24h: Double?
    var marketCap: Double
    
}
