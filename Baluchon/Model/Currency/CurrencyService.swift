//
//  CurrencyService.swift
//  Baluchon
//
//  Created by William on 06/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation

class CurrencyService {
    
    // MARK: - Properties
    private let currencyUrl = "http://data.fixer.io/api/latest?access_key=b26f8bbf56a7e40f26c82f5ec87af7c8&base=EUR&symbols=USD"
    private lazy var url = URL(string: currencyUrl)!
    private var currencySession: URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - Init
    init(currencySession: URLSession = URLSession(configuration: .default)) {
        self.currencySession = currencySession
    }
    
    // MARK: - Methods
    func getRate(callback: @escaping (Bool, Float?) -> Void) {
        task?.cancel()
        task = currencySession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(InfoRate.self, from: data),
                    let usdRate = responseJSON.rates["USD"] else {
                    callback(false, nil)
                    return
                }
                callback(true, usdRate)
            }
        }
        task?.resume()
    }
    

}
