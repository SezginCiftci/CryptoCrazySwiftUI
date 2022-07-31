//
//  Webservice.swift
//  CryptoCrazySwiftUI
//
//  Created by Sezgin Çiftci on 31.07.2022.
//

import Foundation

// (Main Actor) this class's elements are going to work in main thread  -> So it's not neccessary to put any kind of DispatchQuenue.main !!!
//@MainActor
class Webservice {
    
    //MARK: - @escaping task
    func downloadCurrenciesContinuation(url: URL) async throws -> [CryptoCurrency] {
        
        try await withCheckedContinuation({ continuation in
            downloadCurrencies(url: url) { result in
                switch result {
                case .success(let cryptos):
                    continuation.resume(returning: cryptos ?? [])
                case .failure(let error):
//                    continuation.resume(throwing: error)
                    print(error)
                }
            }
        })
    }
    
    
    //MARK: - async await
//    func downloadCurrenciesAsync(url: URL) async throws -> [CryptoCurrency] {
//        let (data, _) = try await URLSession.shared.data(from: url)
//        let currencies = try? JSONDecoder().decode([CryptoCurrency].self, from: data)
//
//        return currencies ?? []
//    }
    //MARK: - @escaping task
    func downloadCurrencies(url: URL, completion: @escaping (Result<[CryptoCurrency]?, DownloadError>) -> ()) {

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription)
                completion(.failure(.badUrl))
                return
            }
            do {
                let cryptoData = try JSONDecoder().decode([CryptoCurrency].self, from: data)
                completion(.success(cryptoData))
            } catch {
                completion(.failure(.dataParseError))
            }
        }.resume()
    }
}

enum DownloadError: Error {
    case badUrl
    case noData
    case dataParseError
}
