//
//  CryptocurrencyGlobalInfoDTO.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation

struct CryptocurrencyGlobalInfoDTO: Codable {
    
    let data: CryptocurrencyGlobalData
    
    struct CryptocurrencyGlobalData: Codable {
        
        let cryptocurrencies: [String: Double]
        
        enum CodingKeys: String, CodingKey {
            case cryptocurrencies = "market_cap_percentage"
        }
        
    }
    
}



/*
 
 "market_cap_percentage": {
    "btc": 52.47738920167948,
    "eth": 15.019438433026732,
    "usdt": 4.483282045130882,
    "bnb": 3.541850710076343,
    "sol": 2.5817755787868957,
    "usdc": 1.348957669043498,
    "steth": 1.172946708248039,
    "xrp": 1.0966170561554975,
    "doge": 0.9010593334758402,
    "ton": 0.84561670062579
  },
 
 */
