//
//  Weather.swift
//  GumtreeCC
//
//  Created by Jing LUO on 18/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let id: Int
    let coord: Coord
    let name: String
    let weatherDetails: [WeatherDetail]
    let temp: Double

    enum CodingKeys: String, CodingKey {
        case id
        case coord
        case name
        case weatherDetails = "weather"
        case main
    }

    enum MainKeys: String, CodingKey {
        case temp
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: .id)
        coord = try container.decode(Coord.self, forKey: .coord)
        name = try container.decode(String.self, forKey: .name)
        weatherDetails = try container.decode([WeatherDetail].self, forKey: .weatherDetails)
        let main = try container.nestedContainer(keyedBy: MainKeys.self, forKey: .main)
        temp = try main.decode(Double.self, forKey: .temp)
    }
}

struct Coord: Decodable {
    let lon: Double
    let lat: Double
}

struct WeatherDetail: Decodable {
    let description: String?
    let icon: String?
}
