//
//  CurrencyServiceTestCase.swift
//  BaluchonTests
//
//  Created by William on 09/11/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import XCTest
@testable import Baluchon

class CurrencyServiceTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    // Test if there is an error
    func testGetRateShouldPostFailedCallbackIfError() {
        // Given
        let currencyService = CurrencyService(currencySession: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getRate { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is no data
    func testGetRateShouldPostFailedCallbackIfNoData() {
        // Given
        let currencyService = CurrencyService(currencySession: URLSessionFake(data: nil, response: nil, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getRate { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there an incorrect response
    func testGetRateShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let currencyService = CurrencyService(currencySession: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseKO, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getRate { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is incorrect data
    func testGetRateShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let currencyService = CurrencyService(currencySession: URLSessionFake(data: FakeResponseData.inccorectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getRate { (success, rate) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(rate)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is response and data correct and no error
    func testGetRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let currencyService = CurrencyService(currencySession: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseOK, error: nil))
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        currencyService.getRate { (success, rate) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(rate)
            
            let rates: [String: Float] = ["USD": 1.133498]
            XCTAssertEqual(rates["USD"], rate)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }


}
