//
//  CryptoDetailView.swift
//  CoinGeckoiOS
//
//  Created by Leonardo Rodríguez González on 09/06/24.
//

import SwiftUI
import Charts

struct ChartDataPoint: Identifiable {
    let id = UUID()
    let date: Date
    let price: Double
}

struct CryptoDetailView: View {
    
    @ObservedObject private var viewModel: CryptoDetailViewModel
    
    init(viewModel: CryptoDetailViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                CryptoDetailHeaderView(cryptocurrency: viewModel.cryptocurrency)
                
                Chart(viewModel.dataPoints) {
                    LineMark(x: .value("Fecha", $0.date), y: .value("Precio", $0.price))
                }
            }.onAppear{
                viewModel.onAppear()
            }
            
            if viewModel.isLoading {
                ProgressView().progressViewStyle(.circular)
            }
        }
    }
}

