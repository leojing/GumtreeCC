//
//  WeatherDetailView.swift
//  GumtreeCC
//
//  Created by Jing LUO on 19/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import UIKit

@IBDesignable
class WeatherDetailView: NibView {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var tempLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var iconImageView: UIImageView!

    @IBInspectable var nameColor: UIColor? {
        get {
            return nameLabel.textColor
        }
        set {
            nameLabel.textColor = newValue
        }
    }

    @IBInspectable var tempColor: UIColor? {
        get {
            return tempLabel.textColor
        }
        set {
            tempLabel.textColor = newValue
        }
    }

    @IBInspectable var descriptionColor: UIColor? {
        get {
            return descriptionLabel.textColor
        }
        set {
            descriptionLabel.textColor = newValue
        }
    }
}

// MARK: - Config Elements with data

extension WeatherDetailView {

    func configureViewWithViewObject(_ viewObject: WeatherDetailViewObject) {
        nameLabel.text = viewObject.nameText
        descriptionLabel.text = viewObject.descriptionText
        tempLabel.text = viewObject.tempText
        #warning("TODO - Set icon image by URL with third party framework like KingFisher/SDWebImage")
    }
}
