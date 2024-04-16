//
//  CryptocurrencyBasicDTO.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 13/04/24.
//

import Foundation

/*
 Este struct se utilza para obtener la respuesta del servicio "api/coins/list", ya que
 la estructura de los datos de dicho JSON contiene estas 3 propiedades, y es necesario
 decodificarlas.
 
 Además, extiende de Codable para que se pueda decodificar de JSON y codificar a JSON
 */
struct CryptocurrencyBasicDTO: Codable {
    var id: String
    var symbol: String
    var name: String
    
    // aquí no se hace un mapeo explícito de propiedades, porque en el JSON y en el struct se llaman igual
    enum CodingKeys: String, CodingKey {
        case id, symbol, name
    }
}
