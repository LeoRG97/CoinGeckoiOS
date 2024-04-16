//
//  Endpoint.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation

struct Endpoint {
    let path: String
    let queryParams: [String: Any]
    let method: HTTPMethod
}
