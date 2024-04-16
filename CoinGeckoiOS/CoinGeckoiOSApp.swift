//
//  CoinGeckoiOSApp.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 13/04/24.
//

import SwiftUI

@main
struct CoinGeckoiOSApp: App {
    var body: some Scene {
        WindowGroup {
            GlobalCryptoListFactory.create() // llama al Factory para renderizar la vista con todas las dependencias inyectadas
        }
    }
}
