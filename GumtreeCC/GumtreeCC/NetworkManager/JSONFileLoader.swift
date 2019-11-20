//
//  JSONFileLoader.swift
//  Transactions
//
//  Created by Jing LUO on 17/11/19.
//  Copyright © 2019 Siphty Pty Ltd. All rights reserved.
//

import Foundation

class JSONFileLoader {

    class func loadJson(fileName: String) -> Data? {

        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                return try Data(contentsOf: url)
            } catch {
                print("Error!! Unable to load \(fileName).json")
            }
        } else {
            print("invalid url")
        }

        return nil
    }
}
