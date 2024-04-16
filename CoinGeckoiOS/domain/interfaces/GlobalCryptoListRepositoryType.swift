//
//  GlobalCryptoListRepositoryType.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 13/04/24.
//

import Foundation

// interfaz para inyección de dependencias (si no se usa Resolver)
protocol GlobalCryptoListRepositoryType {
    
    func getGlobalCryptoList() async -> Result<[Cryptocurrency], CryptocurrencyDomainError>
    
}
