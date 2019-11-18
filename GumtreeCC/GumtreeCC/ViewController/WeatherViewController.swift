//
//  ViewController.swift
//  GumtreeCC
//
//  Created by Jing LUO on 18/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let apiManager = APIManager()
        apiManager.fetchWeatherDetail(EndPoint.weather(.name("London"))) { status in
            guard let status = status else {
                return
            }
            switch status {
            case .success(let weather):
                print(weather as? Weather)

            case .fail(let error):
                print(error.errorDescription)
            }
        }
    }
}

