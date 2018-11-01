//
//  WeatherService.swift
//  Baluchon
//
//  Created by William on 22/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation

class WeatherService {
    
    // MARK: - PROPERTIES
    private let weatherUrl = "https://query.yahooapis.com/v1/public/yql?"
    private lazy var url = URL(string: weatherUrl)!
    private var weatherSession: URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - INIT
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    // MARK: - METHODS
    func getWeather(for cities: [String], callback: @escaping (Bool, WeatherInformations?) -> Void) {
        let request = createWeatherRequest(for: cities)
        
        task?.cancel()
        task = weatherSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(false, nil)
                    print("error1")
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(false, nil)
                    print("error2")
                    return
                }
                guard let responseJSON = try? JSONDecoder().decode(WeatherInformations.self, from: data) else {
                        callback(false, nil)
                        print("error3")
                        return
                }
                let weather = responseJSON
                callback(true, weather)
            }
        }
        task?.resume()
    }
    
    private func createWeatherRequest(for cities: [String]) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        var weatherCities = ""
        for city in cities {
            if city == cities.last {
                weatherCities += "'\(city)'"
            } else {
                weatherCities += "'\(city)', "
            }
        }
        let parameters = "select item.condition, location.city from weather.forecast where woeid in (select woeid from geo.places(1) where text in (\(weatherCities))) and u='c'"
        
        let body = "q=\(parameters)&format=json"
        request.httpBody = body.data(using: .utf8)
        return request
    }
    
}

