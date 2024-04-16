//
//  URLSessionRequestMaker.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation

class URLSessionRequestMaker {
    // clase para construir un objeto URL
    
    func url(endpoint: Endpoint, baseUrl: String) -> URL? {
        var urlComponents = URLComponents(string: baseUrl + endpoint.path)
        
        // map para asignar query params a objetos URLQueryItem
        let urlQueryParams = endpoint.queryParams.map {
            URLQueryItem(name: $0.key, value: "\($0.value)")
        }
        urlComponents?.queryItems = urlQueryParams
        
        let url = urlComponents?.url
        return url
    }
}
