//
//  WeatherFakeResponseData.swift
//  BaluchonTests
//
//  Created by William on 09/11/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation


class WeatherFakeResponseData {
    // Data
    static var correctData: Data? {
        let bundle = Bundle(for: WeatherFakeResponseData.self)
        let url = bundle.url(forResource: "Weather", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let weatherInccorectData = "erreur".data(using: .utf8)!
    
    // Response
    static let responseOK = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let responseKO = HTTPURLResponse(url: URL(string: "https://openclassrooms.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!

    // Error
    class WeatherError: Error {}
    static let error = WeatherError()
       
    
}
