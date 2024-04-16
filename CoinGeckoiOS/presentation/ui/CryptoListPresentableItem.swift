//
//  CryptoListPresentableItem.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 15/04/24.
//

import Foundation

struct CryptoListPresentableItem {
    
    // esta clase define la estructura requerida de los objetos para mostrarlos en el View
    var id: String
    var name: String
    var symbol: String
    var price: String
    var price24h: String
    var volume24h: String
    var marketCap: String
    var isPriceChangePositive: Bool
    
    init(domainModel: Cryptocurrency) {
        self.id = domainModel.id
        self.name = domainModel.name
        self.symbol = domainModel.symbol
        self.price = "\(domainModel.price) $"
        self.price24h = domainModel.price24h != nil ? "\(domainModel.price24h!) %" : "-"
        self.volume24h = domainModel.volume24h != nil ? "\(domainModel.volume24h!) $" : "-"
        self.marketCap = "\(domainModel.marketCap) $"
        self.isPriceChangePositive = (domainModel.price24h ?? 0) >= 0
        // esta propiedad se usa para cambiar el color del texto del cambio en la View
    }
    
}
