//
//  MockAPIManager.swift
//  TransactionsTests
//
//  Created by Jing LUO on 17/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import Foundation

class MockAPIManager: APIService {

    func fetchWeatherDetail(_ config: APIConfig, resultHandler: @escaping ResultHandler) {
        guard let endPoint = config as? MockEndPoint else {
            return resultHandler(.fail(RequestError("Couldn't find server.")))
        }

        requestForLoadFile(endPoint) { data, error in
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
