//
//  GlobalCryptoListView.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 14/04/24.
//

import SwiftUI
import Combine

struct GlobalCryptoListView: View {
    
    @ObservedObject private var viewModel: GlobalCryptoListViewModel
    
    init(viewModel: GlobalCryptoListViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoadingData {
                ProgressView().progressViewStyle(.circular)
            } else {
                if viewModel.showErrorMessage == "" {
                    List {
                        ForEach(viewModel.cryptos, id: \.id) { crypto in
                            CryptoListItemView(item: crypto)
                        }
                    }
                } else {
                    Text(viewModel.showErrorMessage!)
                        .foregroundStyle(.red)
                        .font(.headline)
                }
              
            }
        }.onAppear {
            viewModel.onAppear()
        }
    }
}

/*
 #Preview {
 GlobalCryptoListView()
 }
 
 */
