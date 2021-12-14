//
//  UIViewController+Extension.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit

extension UIViewController {
    static func loadFromNib() -> Self {
        func instantiateFromNib<T: UIViewController>() -> T {
            return T.init(nibName: String(describing: T.self), bundle: nil)
        }
        
        return instantiateFromNib()
    }
    
    var rootWindow: UIWindow? {
        return (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first
    }
}
