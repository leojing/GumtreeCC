//
//  WeatherViewModelTests.swift
//  GumtreeCCTests
//
//  Created by Jing LUO on 20/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import XCTest

class WeatherViewModelTests: XCTestCase {

    var viewModel: WeatherViewModel!
    var mockAPIManager: MockAPIManagerForViewModel!

    override func setUp() {
        mockAPIManager = MockAPIManagerForViewModel()
        viewModel = WeatherViewModel(mockAPIManager)

        // Run Fetch data first to make sure get all data model before test the correction
        let expectation = self.expectation(description: "Fetch Data Succeed, successful to parse DataNode to AccountDisplay")
        viewModel.updatedUI = { _,_ in
            expectation.fulfill()
        }
        viewModel.queryWeatherDetailsByText("test")
        waitForExpectations(timeout: 1.0)
    }

    override func tearDown() {
        viewModel = nil
        mockAPIManager = nil
    }

    func testParseWeatherCorrectly() {
        let expectation = self.expectation(description: "Fetch Data Succeed, successful to parse Weather data model")
        viewModel.updatedUI = { weatherDetail, error in
            guard let weatherDetail = weatherDetail else {
                XCTFail("No weatherDetail.")
                return
            }
            XCTAssertEqual(weatherDetail.nameText, "Shuzenji")
            XCTAssertEqual(weatherDetail.tempText, "62.0 ºF")
            XCTAssertEqual(weatherDetail.descriptionText, "clear sky")
            expectation.fulfill()
        }
        viewModel.queryWeatherDetailsByText("test")
        waitForExpectations(timeout: 1.0)
    }

    func testCellModelToHistoryOperations() {
        viewModel.addCellModelToHistory("test1")
        XCTAssertEqual(viewModel.numberOfRows(), 1)

        viewModel.addCellModelToHistory("test2")
        viewModel.addCellModelToHistory("test3")
        XCTAssertEqual(viewModel.getCellModelForIndex(at: IndexPath(item: 0, section: 0)), "test3")
        XCTAssertEqual(viewModel.getCellModelForIndex(at: IndexPath(item: 1, section: 0)), "test2")
        XCTAssertEqual(viewModel.getCellModelForIndex(at: IndexPath(item: 2, section: 0)), "test1")

        viewModel.deleteCellModelFromHistory(at: IndexPath(item: 1, section: 0))
        XCTAssertEqual(viewModel.numberOfRows(), 2)
        XCTAssertEqual(viewModel.getCellModelForIndex(at: IndexPath(item: 1, section: 0)), "test1")
    }
}


class MockAPIManagerForViewModel: APIService {
    func fetchWeatherDetail(_ config: APIConfig, resultHandler: @escaping ResultHandler) {
        requestForLoadFile(MockEndPoint.correctData) { data, error in
            if let error = error {
                return resultHandler(.fail(error))
            }
            guard let data = data else {
                return resultHandler(.fail(RequestError("Empty data.")))
            }
            do {
                let decoder = JSONDecoder()
                let dataNode = try decoder.decode(Weather.self, from: data)
                resultHandler(.success(dataNode))
            } catch {
                resultHandler(.fail(RequestError("Couldn't parse data.")))
            }
        }
    }
}
