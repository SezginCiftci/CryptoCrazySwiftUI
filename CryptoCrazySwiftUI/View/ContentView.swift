//
//  ContentView.swift
//  CryptoCrazySwiftUI
//
//  Created by Sezgin Çiftci on 31.07.2022.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var cryptoListModel: CryptoListViewModel
    
    init() {
        self.cryptoListModel = CryptoListViewModel()
    }
    
    var body: some View {
        
        NavigationView {
            
            List(cryptoListModel.cryptoList, id: \.id) { crypto in
                VStack {
                    Text(crypto.currency)
                        .font(.title3)
                        .foregroundColor(.blue)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text(crypto.price)
                        .foregroundColor(.black)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }.navigationTitle(Text("Crypto Crazy"))
            
        }.task {
            
            await cryptoListModel.downloadCryptosContinuation(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
            
            //MARK: - async await
//            await cryptoListModel.downloadCryptosAsync(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
        }
        
        //MARK: - @escaping task
//        .onAppear {
//
//            cryptoListModel.downloadCryptos(url: URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!)
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//FreeApiForCurrencies


// Atil Book Currency Static Data
//https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json
