//
//  APIManager.swift
//  GumtreeCC
//
//  Created by Jing LUO on 18/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import Foundation

class APIManager: APIService {

    func fetchWeatherDetail(_ config: APIConfig, resultHandler: @escaping ResultHandler) {
        guard let endPoint = config as? EndPoint else {
            return resultHandler(.fail(RequestError("Couldn't find server.")))
        }

        networkRequest(endPoint) { data, error in
            if let error = error {
                return resultHandler(.fail(error))
            }
            guard let data = data else {
                return resultHandler(.fail(RequestError("Empty data.")))
            }
            do {
                let decoder = JSONDecoder()
                let weather = try decoder.decode(Weather.self, from: data)
                resultHandler(.success(weather))
            } catch {
                resultHandler(.fail(RequestError("Couldn't parse data.")))
            }
        }
    }
}
