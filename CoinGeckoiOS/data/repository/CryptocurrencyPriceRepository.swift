//
//  CryptocurrencyPriceHistoryRepository.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 26/05/24.
//

import Foundation

class CryptocurrencyPriceHistoryDomainMapper {
    func map(priceHistoryDto: CryptocurrencyPriceHistoryDTO) -> CryptocurrencyPriceHistory {
        
        let dataPoints: [CryptocurrencyPriceHistory.DataPoint] = priceHistoryDto.prices.compactMap { dataPoint in
            
            // extraer la fecha de la primera posición del array y el precio de la segunda posición
            guard dataPoint.count >= 2,
                  let date = timestampToDate(timestamp: dataPoint[0]), let price = dataPoint[1].toCurrency() else {
                return nil
            }
            
            return CryptocurrencyPriceHistory.DataPoint(price: price, date: date)
        }
        
        // retorna un nuevo objeto CryptocurrencyPriceHistory con los dataPoints obtenidos
        return CryptocurrencyPriceHistory(prices: dataPoints)
        
    }
    
    private func timestampToDate(timestamp: Double) -> Date? {
        // convertir el timestamp en una fecha en formato de Swift
        let calendar  = Calendar.current
        
        let components = Calendar.current.dateComponents([.day, .month, .year], from:  Date(timeIntervalSince1970: timestamp / 1000))
        
        guard let date = calendar.date(from: components) else { return nil }
        
        return date
    }
}

class CryptocurrencyPriceRepository: CryptocurrencyPriceHistoryRepositoryType {
    
    private let apiDataSource: ApiPriceDataSourceType
    
    private let domainMapper: CryptocurrencyPriceHistoryDomainMapper
    private let errorMapper: CryptocurrencyDomainErrorMapper
    
    init(apiDataSource: ApiPriceDataSourceType, domainMapper: CryptocurrencyPriceHistoryDomainMapper, errorMapper: CryptocurrencyDomainErrorMapper) {
        self.apiDataSource = apiDataSource
        self.domainMapper = domainMapper
        self.errorMapper = errorMapper
    }
    
    func getPriceHistory(id: String, days: Int) async -> Result<CryptocurrencyPriceHistory, CryptocurrencyDomainError> {
        let result = await apiDataSource.getPriceHistory(id: id, days: days)
        
        // verificar que la respuesta de la API sea success
        guard case .success(let priceHistory) = result else {
            return .failure(errorMapper.map(error: result.failureValue as? HTTPClientError))
        }
        
        return .success(domainMapper.map(priceHistoryDto: priceHistory))
    }
    
}
