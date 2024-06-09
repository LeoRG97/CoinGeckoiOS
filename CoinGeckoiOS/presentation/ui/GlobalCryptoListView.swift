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
    private let createCryptoDetailView: CreateCryptoDetailView
    
    init(viewModel: GlobalCryptoListViewModel, createCryptoDetailView: CreateCryptoDetailView) {
        self.viewModel = viewModel
        self.createCryptoDetailView = createCryptoDetailView
    }
    
    var body: some View {
        VStack {
            if viewModel.isLoadingData {
                ProgressView().progressViewStyle(.circular)
            } else {
                if viewModel.showErrorMessage == "" {
                    NavigationStack {
                        List {
                            ForEach(viewModel.cryptos, id: \.id) { crypto in
                                NavigationLink{
                                    createCryptoDetailView.create(cryptocurrency: crypto) // composition root injection
                                } label: {
                                    CryptoListItemView(item: crypto)
                                }
                               
                            }
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
