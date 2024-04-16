//
//  CryptoListItemView.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 15/04/24.
//

import SwiftUI

struct CryptoListItemView: View {
    
    let item: CryptoListPresentableItem
    
    var body: some View {
        VStack {
            HStack {
                
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.title3)
                        .lineLimit(1)
                    Text(item.symbol)
                        .font(.headline)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text(item.price)
                        .font(.headline)
                        .lineLimit(1)
                    Text((item.isPriceChangePositive ? "+" : "" ) + item.price24h)
                        .font(.headline)
                        .foregroundStyle(item.isPriceChangePositive ? .green : .red)
                }
                
            }
            HStack {
                
                VStack(alignment: .leading) {
                    Text("Market cap")
                        .font(.system(size: 10))
                    Text("24 h")
                        .font(.system(size: 10))
                }
                
                Spacer()
                VStack(alignment: .trailing) {
                    Text(item.marketCap)
                        .font(.system(size: 10))
                    Text(item.volume24h)
                        .font(.system(size: 10))
                }
                
            }
        }
    }
}

let demoItem = CryptoListPresentableItem(domainModel: Cryptocurrency(id: "1212", name: "VinciBit", symbol: "vib", price: 1223.12, price24h: 22.2, marketCap: 120.2))

#Preview {
    CryptoListItemView(item: demoItem)
}
