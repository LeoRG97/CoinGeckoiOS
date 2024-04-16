//
//  URLSessionErrorResolver.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation

class URLSessionErrorResolver {
    
    // clase para determinar si el error de la solicitud HTTP es del lado del cliente o del servidor
    
    func resolve(statusCode: Int) -> HTTPClientError {
        guard statusCode != 429 else {
            return .tooManyRequests
        }
        guard statusCode < 500 else {
            return .clientError
        }
        return .serverError
    }
    
    func resolve(error: Error) -> HTTPClientError {
        return .genericError
    }
    
}
