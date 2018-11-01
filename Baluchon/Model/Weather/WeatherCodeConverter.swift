//
//  WeatherCodeConverter.swift
//  Baluchon
//
//  Created by William on 31/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation

enum WeatherCode: String {
    case sunny
    case rain
    case cloudy
    case snow
    case cloud
    case wind
    case storm
}

class CodeConverter {
    
    static let codeContainer: [(WeatherCode, [String])] =
        [(WeatherCode.sunny, Constants.YahooWeatherCode.sunny),
         (WeatherCode.rain, Constants.YahooWeatherCode.rain),
         (WeatherCode.cloudy, Constants.YahooWeatherCode.cloudy),
         (WeatherCode.snow, Constants.YahooWeatherCode.snow),
         (WeatherCode.cloud, Constants.YahooWeatherCode.cloud),
         (WeatherCode.wind, Constants.YahooWeatherCode.wind),
         (WeatherCode.storm, Constants.YahooWeatherCode.storm)]
    
    
    static func convertWeatherCodeInImage(weatherCode: String) -> String {
        var imageString = ""
        
        for code in codeContainer {
            if code.1.contains(weatherCode) {
                imageString = code.0.rawValue
            }
        }
        return imageString
    }
    
}
