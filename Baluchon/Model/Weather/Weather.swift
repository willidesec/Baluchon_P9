//
//  File.swift
//  Baluchon
//
//  Created by William on 05/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation

struct WeatherInformations: Decodable {
    let query: WeatherQuery
}

struct WeatherQuery: Decodable {
    let count: Int
    let results: WeatherResults
}

struct WeatherResults: Decodable {
    let channel: [WeatherChannel]
}

struct WeatherChannel: Decodable {
    let item: WeatherItem
    let location: WeatherLocation
}

struct WeatherLocation: Decodable {
    let city: String
}

struct WeatherItem: Decodable {
    let condition: WeatherCondition
}

struct WeatherCondition: Decodable {
    let temp: String
    let text: String
    let code: String
}






