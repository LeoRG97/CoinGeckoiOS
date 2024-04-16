//
//  CryptocurrencyPresentableErrorMapper.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 15/04/24.
//

import Foundation

class CryptocurrencyPresentableErrorMapper {
    
    // función para devolver un mensaje de acuerdo al tipo de error
    func map(error: CryptocurrencyDomainError?) -> String {
        
        guard error == .tooManyRequests else {
            return "Something went wrong"
        }
      
        return "You have exceeded the limit of requests. Try again later"
    }
    
}
