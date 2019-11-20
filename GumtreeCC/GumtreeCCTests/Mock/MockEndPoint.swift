//
//  MockEndPoint.swift
//  TransactionsTests
//
//  Created by Jing LUO on 17/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import Foundation

enum MockEndPoint: APIConfig {
    case correctData
    case wrongFormatData
    case missingWeatherDetailData

    var resourceName: String {
        switch self {
        case .correctData:
            return "correctData"
        case .wrongFormatData:
            return "wrongFormatData"
        case .missingWeatherDetailData:
            return "missingWeatherDetailData"
        }
    }

    var urlScheme: String? {
        return nil
    }

    var baseURL: String? {
        return nil
    }

    var path: String? {
        return nil
    }

    var method: String? {
        return nil
    }

    var header: [String : Any]? {
        return nil
    }

    var parameters: [String : Any]? {
        return nil
    }

    var fullUrl: URL? {
        return nil
    }
}
