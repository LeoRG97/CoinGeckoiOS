//
//  CrypticurrencyRepository.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 13/04/24.
//

import Foundation






class CryptocurrencyRepository: GlobalCryptoListRepositoryType {
    
    private let apiDataSource: ApiDataSourceType
    private let errorMapper: CryptocurrencyDomainErrorMapper
    private let domainMapper: CryptocurrencyDomainMapper
    
    init(apiDataSource: ApiDataSourceType, errorMapper: CryptocurrencyDomainErrorMapper, domainMapper: CryptocurrencyDomainMapper) {
        self.apiDataSource = apiDataSource
        self.errorMapper = errorMapper
        self.domainMapper = domainMapper
    }
    
    func getGlobalCryptoList() async -> Result<[Cryptocurrency], CryptocurrencyDomainError> {
        
        //https://api.coingecko.com/api/v3/global
        let symbolListResult = await apiDataSource.getGlobalCryptoSymbolList()
        //https://api.coingecko.com/api/v3/coins/list
        let cryptoListResult = await apiDataSource.getCryptoList()
        
        
        guard case .success(let symbolList) = symbolListResult else {
            return .failure(errorMapper.map(error: symbolListResult.failureValue as? HTTPClientError))
        }
        guard case .success(let cryptoList) = cryptoListResult else {
            return .failure(errorMapper.map(error: cryptoListResult.failureValue as? HTTPClientError))
        }
        
        let cryptocurrencyBuilderList = domainMapper.getCryptoCurrencyBuilderList(symbolList: symbolList, cryptoList: cryptoList)
        
        // hacer un map para recuperar un array con los ID de las criptomonedas
        //https://api.coingecko.com/api/v3/simple/price?ids=3&vs_currencies=2
        
        // para no saturar las 30 peticiones por minuto de la API, mejor reduje la lista de elemntos
        let newCryptocurrencyBuilderList = cryptocurrencyBuilderList[0...14]

        let priceInfoResult = await apiDataSource.getPriceInfoForCryptos(id: newCryptocurrencyBuilderList.map { $0.id })
        
        guard case .success(let priceInfo) = priceInfoResult else {
            return .failure(errorMapper.map(error: priceInfoResult.failureValue as? HTTPClientError))
        }
        
        let cryptocurrency = domainMapper.map(cryptocurrencyBuilderList: cryptocurrencyBuilderList, priceInfo: priceInfo)
        
        /*
        cryptocurrencyBuilderList.forEach { cryptocurrencyBuilderItem in
            // si el ID de la criptomoneda existe en el Dictionary de los precios
            if let priceInfo = priceInfo[cryptocurrencyBuilderItem.id] {
                cryptocurrencyBuilderItem.price = priceInfo.price
                cryptocurrencyBuilderItem.volume24h = priceInfo.volume24h
                cryptocurrencyBuilderItem.marketCap = priceInfo.marketCap
                cryptocurrencyBuilderItem.price24h = priceInfo.price24h
            }
        }
         */
        
        
        // compactMap excluye los items que no puedan ser construidos por el patrón Builder
        return .success(cryptocurrency)

       
    }
    
}
