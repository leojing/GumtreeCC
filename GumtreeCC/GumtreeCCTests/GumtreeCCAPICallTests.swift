//
//  GumtreeCCTests.swift
//  GumtreeCCTests
//
//  Created by Jing LUO on 18/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import XCTest
@testable import GumtreeCC

class GumtreeCCTests: XCTestCase {

    var mockAPIManager: MockAPIManager!

    override func setUp() {
        mockAPIManager = MockAPIManager()
    }

    override func tearDown() {
        mockAPIManager = nil
    }


    func testCorrectData() {
        let expectation = self.expectation(description: "Fetch Data Succeed")
        let config = MockEndPoint.correctData
        mockAPIManager.fetchWeatherDetail(config) { status in
            guard let status = status else {
                XCTFail("No status.")
                return
            }
            // Assert
            switch status {
            case .success(let weather):
                XCTAssertNotNil(weather)
                if let weather = weather as? Weather {
                    XCTAssertEqual(weather.name, "Shuzenji")
                }
            case .fail(_):
                XCTFail("Fatch data from Correct data file shouldn't fail.")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }

    func testWrongFormatData() {
        let expectation = self.expectation(description: "Fetch Data failed")
        mockAPIManager.fetchWeatherDetail(MockEndPoint.wrongFormatData) { status in
            guard let status = status else {
                XCTFail("No status.")
                return
            }
            // Assert
            switch status {
            case .success(let data):
                XCTAssertNil(data)
            case .fail(let error):
                XCTAssertEqual(error.errorDescription ?? "", "Couldn't parse data.")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }

    func testMissingWeatherDetailData() {
        let expectation = self.expectation(description: "Fetch Data failed, as Weather detail is mandatory, so parse will failed")
        mockAPIManager.fetchWeatherDetail(MockEndPoint.missingWeatherDetailData) { status in
            guard let status = status else {
                XCTFail("No status.")
                return
            }
            // Assert
            switch status {
            case .success(let data):
                XCTAssertNil(data)
            case .fail(let error):
                XCTAssertEqual(error.errorDescription ?? "", "Couldn't parse data.")
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0)
    }
}
