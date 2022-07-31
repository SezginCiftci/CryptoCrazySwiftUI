//
//  CryptoViewModel.swift
//  CryptoCrazySwiftUI
//
//  Created by Sezgin Çiftci on 31.07.2022.
//

import Foundation

class CryptoListViewModel: ObservableObject {
    
    let service = Webservice()
    
    @Published var cryptoList = [CryptoViewModel]()
    
    //MARK: - continuation
    func downloadCryptosContinuation(url: URL) async {
        do {
            let cryptos = try await service.downloadCurrenciesContinuation(url: url)
            DispatchQueue.main.async {
                self.cryptoList = cryptos.map(CryptoViewModel.init)
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    
    //MARK: - async await
//    func downloadCryptosAsync(url: URL) async {
//        do {
//            let cryptos = try await service.downloadCurrenciesAsync(url: url)
//            DispatchQueue.main.async {
//                self.cryptoList = cryptos.map(CryptoViewModel.init)
//            }
//        } catch {
//            print("Error: \(error.localizedDescription)")
//        }
//    }
//
    //MARK: - @escaping task
//    func downloadCryptos(url: URL) {
//
//        service.downloadCurrencies(url: url) { result in
//            switch result {
//            case .success(let cryptos):
//                guard let cryptos = cryptos else { return }
//                DispatchQueue.main.async {
//                    self.cryptoList = cryptos.map(CryptoViewModel.init)
//                }
//            case .failure(let error):
//                print(error)
//            }
//        }
//    }
}


struct CryptoViewModel {
    
    let crypto: CryptoCurrency
    
    var id: UUID? {
        crypto.id
    }
    
    var currency: String {
        crypto.currency
    }
    
    var price: String {
        crypto.price
    }
    
}
