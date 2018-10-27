//
//  WeatherService.swift
//  Baluchon
//
//  Created by William on 22/10/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import Foundation

class WeatherService {
    
    // MARK: - Properties
    private let weatherUrl = "https://query.yahooapis.com/v1/public/yql?"
    private lazy var url = URL(string: weatherUrl)!
    private var weatherSession: URLSession
    private var task: URLSessionDataTask?
    
    // MARK: - Init
    init(weatherSession: URLSession = URLSession(configuration: .default)) {
        self.weatherSession = weatherSession
    }
    
    // MARK: - Methods
    func getWeather(callback: @escaping (Bool, [Weather]?) -> Void) {
        let request = createWeatherRequest()
        
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
                guard let responseJSON = try? JSONDecoder().decode(WeatherInformations.self, from: data),
                    let weatherTemp = responseJSON.query.results.channel.item.condition.temp,
                    let weatherDescription = responseJSON.query.results.channel.item.condition.text,
                    let weatherLocation = responseJSON.query.results.channel.location.city else {
                        callback(false, nil)
                        print("error3")
                        return
                }
                print(weatherLocation)
                print(weatherTemp)
                print(weatherDescription)
                var weathers = [Weather]()
                let weather = Weather(city: weatherLocation, temperature: weatherTemp, text: weatherDescription)
                weathers.append(weather)
                callback(true, weathers)
            }
        }
        task?.resume()
    }
    
    private func createWeatherRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = "q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22lyon%22)%20and%20u%3D%22c%22&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        request.httpBody = body.data(using: .utf8)
        return request
    }
    
}

