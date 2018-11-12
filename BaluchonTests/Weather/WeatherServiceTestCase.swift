//
//  WeatherServiceTestCase.swift
//  BaluchonTests
//
//  Created by William on 09/11/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import XCTest
@testable import Baluchon

class WeatherServiceTestCase: XCTestCase {

    
    override func setUp() {
    }
    
    // Test if there is an error
    func testGetWeatherShouldPostFailedCallbackIfError() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: TranslateFakeResponseData.error))
        let countries = ["New York"]
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: countries) { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is no data
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: nil, response: nil, error: nil))
        let countries = ["New York"]
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: countries) { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is incorrect response
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: WeatherFakeResponseData.correctData, response: WeatherFakeResponseData.responseKO, error: nil))
        let countries = ["New York"]
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: countries) { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is incorrect data
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: WeatherFakeResponseData.weatherInccorectData, response: WeatherFakeResponseData.responseOK, error: nil))
        let countries = ["New York"]
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: countries) { (success, weather) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(weather)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is correct data and response and no error
    func testGetWeatherShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let weatherService = WeatherService(weatherSession: URLSessionFake(data: WeatherFakeResponseData.correctData, response: WeatherFakeResponseData.responseOK, error: nil))
        let countries = ["New York"]
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(for: countries) { (success, weather) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(weather)
            
            let count = 2
            let city = "New York"
            let code = "33"
            let temperature = "3"
            let description = "Mostly Clear"
            
            XCTAssertEqual(count, weather!.query.count)
            XCTAssertEqual(city, weather!.query.results.channel[0].location.city)
            XCTAssertEqual(code, weather!.query.results.channel[0].item.condition.code)
            XCTAssertEqual(temperature, weather!.query.results.channel[0].item.condition.temp)
            XCTAssertEqual(description, weather!.query.results.channel[0].item.condition.text)
            
            let imageString = CodeConverter.convertWeatherCodeInImage(weatherCode: weather!.query.results.channel[0].item.condition.code)
            XCTAssertEqual(imageString, "sunny")
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }


}
