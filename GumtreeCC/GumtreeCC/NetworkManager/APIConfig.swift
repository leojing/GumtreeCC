//
//  APIConfig.swift
//  GumtreeCC
//
//  Created by Jing LUO on 18/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import Foundation

struct RequestError : LocalizedError {

    var errorDescription: String? { return mMsg }
    var failureReason: String? { return "" }
    var recoverySuggestion: String? { return "" }
    var helpAnchor: String? { return "" }

    private var mMsg : String

    init(_ description: String) {
        mMsg = description
    }
}

protocol APIConfig {
    var resourceName: String { get }
    var urlScheme: String? { get }
    var baseURL: String? { get }
    var path: String? { get }
    var method: String? { get }
    var header: [String: Any]? { get }
    var parameters: [String: Any]? { get }
    var fullUrl: URL? { get }
}

enum WeatherByType {
    fileprivate static let API_KEY = "95d190a434083879a6398aafd54d9e73"

    case name(String)
    case zipcode(String)
    case gps((Double, Double))

    var parameters: [String: Any]? {
        switch self {
        case .name(let name):
            return ["q": name]
        case .zipcode(let code):
            return ["zip": code]
        case .gps(let location):
            return ["lat": location.0, "lon": location.1]
        }
    }
}

enum EndPoint: APIConfig {

    case weather(WeatherByType)

    var resourceName: String {
        switch self {
        case .weather(_):
            return "weather"
        }
    }

    var urlScheme: String? {
        switch self {
        case .weather(_):
            return "http"
        }
    }

    var baseURL: String? {
        switch self {
        case .weather(_):
            return "api.openweathermap.org"
        }
    }

    var path: String? {
        switch self {
        case .weather(_):
            return "/data/2.5/"
        }
    }

    var method: String? {
        switch self {
        case .weather(_):
            return "GET"
        }
    }

    var header: [String: Any]? {
        switch self {
        case .weather(_):
            return nil
        }
    }

    var parameters: [String: Any]? {
        switch self {
        case .weather(let type):
            return type.parameters?.merging(["APPID": WeatherByType.API_KEY], uniquingKeysWith: {(current, _) in current})
        }
    }

    var fullUrl: URL? {
        switch self {
        case .weather(_):
            guard let baseUrl = baseURL,
                let path = path else { return nil }

            var components = URLComponents()
            components.scheme = urlScheme
            components.host = baseUrl
            components.path = path + resourceName

            if let parameters = parameters,
                !parameters.isEmpty {
                components.queryItems = [URLQueryItem]()
                for (key, value) in parameters {
                    let queryItem = URLQueryItem(name: key, value: "\(value)")
                    components.queryItems!.append(queryItem)
                }
            }

            return components.url
        }
    }

}
