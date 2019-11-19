//
//  UIViewController+Extension.swift
//  Transactions
//
//  Created by Jing LUO on 17/11/19.
//  Copyright © 2019 Jing LUO. All rights reserved.
//

import UIKit


extension UIViewController {

    func showAlert(_ title: String?, _ message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: "Button.Ok".localizedValue(), style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}
