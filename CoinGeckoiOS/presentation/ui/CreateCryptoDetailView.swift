//
//  CreateCryptoDetailView.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 09/06/24.
//

import Foundation

protocol CreateCryptoDetailView {
    func create(cryptocurrency: CryptoListPresentableItem) -> CryptoDetailView
}
