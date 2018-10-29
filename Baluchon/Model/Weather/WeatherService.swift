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
    var weathers = [Weather]()
    
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
                    let count = responseJSON.query.count else {
//                    let weatherTemp = responseJSON.query.results.channel.item.condition.temp,
//                    let weatherDescription = responseJSON.query.results.channel.item.condition.text,
//                    let weatherLocation = responseJSON.query.results.channel.location.city,
//                    let weatherCode = responseJSON.query.results.channel.item.condition.code else {
                        callback(false, nil)
                        print("error3")
                        return
                }
                print(count)
                for i in 0..<count {
                    guard let weatherTemp = responseJSON.query.results.channel[i].item.condition.temp,
                    let weatherDescription = responseJSON.query.results.channel[i].item.condition.text,
                    let weatherLocation = responseJSON.query.results.channel[i].location.city,
                    let weatherCode = responseJSON.query.results.channel[i].item.condition.code else {
                        callback(false, nil)
                        print("error3")
                        return
                    }
                    guard let codeInt = Int(weatherCode) else { return }

                    var code: WeatherCode {
                        let code = codeInt
                        switch code {
                        case 0, 2, 23, 24:
                            return .wind
                        case 26, 27, 28, 29, 30, 44:
                            return .cloudy
                        case 5, 6, 8, 9, 11, 12, 35, 40:
                            return .rain
                        case 20, 21, 22:
                            return .cloud
                        case 7, 13, 14, 15, 16, 17, 18, 19, 25, 41, 46:
                            return .snow
                        case 1, 3, 4, 37, 38, 39, 45, 47:
                            return .storm
                        case 32, 34, 36:
                            return .sunny
                        default:
                            return .sunny
                        }
                    }
                    
                    let weather = Weather(city: weatherLocation, temperature: weatherTemp, text: weatherDescription, code: code)
                    self.weathers.append(weather)
                }
                print(self.weathers)

                callback(true, self.weathers)
            }
        }
        task?.resume()
    }
    
    private func createWeatherRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let body = "q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%20in%20(%22lyon%22%2C%20%22lille%22))&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
        request.httpBody = body.data(using: .utf8)
        return request
    }
    
}

