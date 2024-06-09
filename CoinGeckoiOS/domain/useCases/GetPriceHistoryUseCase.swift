//
//  GetPriceHistoryUseCase.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 26/05/24.
//

import Foundation



class GetPriceHistoryUseCase {
    
    private let repository:CryptocurrencyPriceHistoryRepositoryType
    
    init(repository: CryptocurrencyPriceHistoryRepositoryType) {
        self.repository = repository
    }
    
    func execute(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError> {
        return await repository.getPriceHistory(id: id, days: days)
    }
}
