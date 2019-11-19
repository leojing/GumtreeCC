//
//  UIColor+Extension.swift
//  Transactions
//
//  Created by Jing LUO on 17/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(red: Int, green: Int, blue: Int) {
        self.init(red: CGFloat(red)/255,
                  green: CGFloat(green)/255,
                  blue: CGFloat(blue)/255,
                  alpha: 1.0)
    }

    class var headerBackground: UIColor {
        return UIColor(red: 146, green: 176, blue: 176)
    }

    class var greyBackground: UIColor {
        return UIColor(red: 246, green: 246, blue: 246)
    }

    class var yellowBackground: UIColor {
        return UIColor(red: 255, green: 204, blue: 0)
    }

    class var greyTextColor: UIColor {
        return UIColor(red: 138, green: 138, blue: 138)
    }

    class var accountTextColor: UIColor {
        return UIColor(red: 35, green: 31, blue: 32)
    }
}
