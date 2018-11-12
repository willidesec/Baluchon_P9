//
//  TranslateServiceTestCase.swift
//  BaluchonTests
//
//  Created by William on 09/11/2018.
//  Copyright © 2018 William Désécot. All rights reserved.
//

import XCTest
@testable import Baluchon

class TranslateServiceTestCase: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    // Test if there is an error
    func testGetTraductionShouldPostFailedCallbackIfError() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: TranslateFakeResponseData.error))
        let text = "Bonjour"
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTraduction(of: text) { (success, translatedText) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is no data
    func testGetTraductionShouldPostFailedCallbackIfNoData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: nil, response: nil, error: nil))
        let text = "Bonjour"
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTraduction(of: text) { (success, translatedText) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is incorrect response
    func testGetTraductionShouldPostFailedCallbackIfIncorrectResponse() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: TranslateFakeResponseData.correctData, response: TranslateFakeResponseData.responseKO, error: nil))
        let text = "Bonjour"
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTraduction(of: text) { (success, translatedText) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is incorrect data
    func testGetTraductionShouldPostFailedCallbackIfIncorrectData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: TranslateFakeResponseData.translateInccorectData, response: TranslateFakeResponseData.responseOK, error: nil))
        let text = "Bonjour"
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTraduction(of: text) { (success, translatedText) in
            // Then
            XCTAssertFalse(success)
            XCTAssertNil(translatedText)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Test if there is correct data and response and no error
    func testGetTraductionShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        // Given
        let translateService = TranslateService(translateSession: URLSessionFake(data: TranslateFakeResponseData.correctData, response: TranslateFakeResponseData.responseOK, error: nil))
        let text = "Bonjour"
        // When
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translateService.getTraduction(of: text) { (success, translatedText) in
            // Then
            XCTAssertTrue(success)
            XCTAssertNotNil(translatedText)
            
            let translation = "Hello"
            XCTAssertEqual(translation, translatedText)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }

}
