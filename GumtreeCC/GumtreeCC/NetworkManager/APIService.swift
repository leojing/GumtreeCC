//
//  APIService.swift
//  GumtreeCC
//
//  Created by Jing LUO on 18/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ jsonResponse: Data?, _ error: RequestError?) -> Void
typealias ResultHandler = (_ status: RequestStatus?) -> Void

enum RequestStatus {
    case success(Any?)
    case fail(RequestError)
}

protocol APIService {
    func fetchWeatherDetail(_ config: APIConfig, resultHandler: @escaping ResultHandler)

    func requestForLoadFile(_ config: APIConfig, completionHandler: @escaping CompletionHandler)
    func networkRequest(_ config: APIConfig, completionHandler: @escaping CompletionHandler)
}

extension APIService {

    func requestForLoadFile(_ config: APIConfig, completionHandler: @escaping CompletionHandler) {
        guard let data = JSONFileLoader.loadJson(fileName: config.resourceName) else {
            return completionHandler(nil, RequestError("Parse Content failed."))
        }
        completionHandler(data, nil)
    }

    func networkRequest(_ config: APIConfig, completionHandler: @escaping CompletionHandler) {
        guard let endPoint = config as? EndPoint else {
            completionHandler(nil, RequestError("Couldn't find server."))
            return
        }

        URLCache.shared.removeAllCachedResponses()
        guard let url = endPoint.fullUrl else {
            completionHandler(nil, RequestError("Url is nil."))
            return
        }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                return completionHandler(nil, RequestError(error.localizedDescription))
            }
            completionHandler(data, nil)
        }
        task.resume()
    }
}
