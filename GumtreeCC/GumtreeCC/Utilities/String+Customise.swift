//
//  String+Customise.swift
//  Transactions
//
//  Created by Jing LUO on 17/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import Foundation

// MARK: - Extension for Localizable

extension String {
    func localizedValue() -> String {
        return NSLocalizedString(self, comment: "")
    }

    func doStringContainsNumber() -> Bool{

        let numberRegEx  = ".*[0-9]+.*"
        let testCase = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let containsNumber = testCase.evaluate(with: self)

        return containsNumber
    }

}
