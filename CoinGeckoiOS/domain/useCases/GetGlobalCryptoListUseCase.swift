//
//  GetGlobalCryptoListUseCase.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 13/04/24.
//

import Foundation

protocol GetGlobalCryptoListType {
    func execute() async -> Result<[Cryptocurrency], CryptocurrencyDomainError>
}


class GetGlobalCryptoListUseCase: GetGlobalCryptoListType {
    
    private let repository: GlobalCryptoListRepositoryType
    
    init(repository: GlobalCryptoListRepositoryType) {
        self.repository = repository
    }

    // "execute()" para ejecutar el caso de uso como una función y no como una clase
    func execute() async -> Result<[Cryptocurrency], CryptocurrencyDomainError>{
        // función asíncrona que retorna un Resultado con un array de Cryptocurrency, o un Error
        
        let result = await repository.getGlobalCryptoList()
        
        guard let cryptoList = try? result.get() else {
            // revisamos si viene un error de la solicitud, de lo contrario retornamos un error genérico
            guard case .failure(let error) = result else {
                return .failure(.generic)
            }
            
            return .failure(error)

        }
        
        // ordenar lista por capitalización de mercadp
        let orderedCryptoList = cryptoList.sorted {$0.marketCap > $1.marketCap} // el equivalente a "a" y "b" en un sort de Java
        

        return .success(orderedCryptoList) // caso "success" de un objeto Result<>
        
    }
    
}
