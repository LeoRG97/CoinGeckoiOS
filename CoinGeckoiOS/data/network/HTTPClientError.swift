//
//  HTTPClientError.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 13/04/24.
//

// ESTO PUEDE IR EN EL DIRECTORIO "CORE"
import Foundation

enum HTTPClientError: Error {
    case clientError // statusCode menor a 500
    case serverError // statusCode mayor o igual a 500
    case genericError // un error que no esté mapeado
    case parsingError
    case badURL
    case responseError
    case tooManyRequests // statusCode igual a 429
}
