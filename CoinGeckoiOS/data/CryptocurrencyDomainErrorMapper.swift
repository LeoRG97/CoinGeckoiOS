//
//  CryptocurrencyDomainErrorMapper.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import Foundation

class CryptocurrencyDomainErrorMapper {
    // mapear todos los errores HTTPClientError a su equivalente de tipo CryptocurrencyDomainError
    func map(error: HTTPClientError?) -> CryptocurrencyDomainError {
        guard error == .tooManyRequests else {
            return .generic
        }
        return .tooManyRequests
    }
}
