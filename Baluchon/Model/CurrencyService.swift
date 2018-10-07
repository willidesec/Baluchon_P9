//
//  CurrencyService.swift
//  Baluchon
//
//  Created by William on 06/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation

class CurrencyService {
    
    static let shared = CurrencyService()
    private init() {}
    
    private static let currencyUrl = "http://data.fixer.io/api/latest?access_key=b26f8bbf56a7e40f26c82f5ec87af7c8&base=EUR&symbols=USD"
    private static let url = URL(string: currencyUrl)!
    
    private var task: URLSessionDataTask?
    
    private var currencySession = URLSession(configuration: .default)
    
    init(currencySession: URLSession) {
        self.currencySession = currencySession
    }
    
    func getRate(callback: @escaping (Bool, InfoRate?) -> Void) {
        task?.cancel()
        task = currencySession.dataTask(with: CurrencyService.url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(InfoRate.self, from: data) else {
                    callback(false, nil)
                    return
                }
                print(responseJSON)
            }
        }
        task?.resume()
    }
    

}
