//
//  CryptocurrencyPriceHistoryRepositoryType.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 26/05/24.
//

import Foundation

protocol CryptocurrencyPriceHistoryRepositoryType {
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError>
}
