//
//  UIFont+Extension.swift
//  Transactions
//
//  Created by Jing LUO on 17/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import UIKit

public extension UIFont {

    static func regularFontSize(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }

    static func boldFontSize(_ size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }

    static func HelveticaNeueLightFontSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Light", size: size) ?? UIFont.regularFontSize(size)
    }

    static func HelveticaNeueFontSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue", size: size) ?? UIFont.regularFontSize(size)
    }

    static func HelveticaNeueBoldFontSize(_ size: CGFloat) -> UIFont {
        return UIFont(name: "HelveticaNeue-Bold", size: size) ?? UIFont.boldFontSize(size)
    }
}
