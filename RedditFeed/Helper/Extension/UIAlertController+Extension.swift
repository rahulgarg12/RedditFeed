//
//  UIAlertController+Extension.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit

extension UIAlertController {
    
    static func getAlert(title: String?, message: String?, buttonTitle: String = "Ok") -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
        return alert
    }
}

