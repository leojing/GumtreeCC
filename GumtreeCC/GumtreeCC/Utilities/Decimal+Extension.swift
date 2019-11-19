//
//  Decimal+Extension.swift
//  Transactions
//
//  Created by Jing LUO on 17/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import Foundation


extension String {
    static var currencySymbol = "$"
    static var minus = "-"
}

extension Decimal {

    var currencyFormatter: String? {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumIntegerDigits = 1
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        let symbol = self < 0 ? (.minus + .currencySymbol) : .currencySymbol
        guard let number = formatter.string(from: NSDecimalNumber(decimal: abs(self))) else {
            return nil
        }
        return symbol + number
    }
}
