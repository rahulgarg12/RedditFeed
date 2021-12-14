//
//  UIApplication+Extension.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit

extension UIApplication {
    var keyWindowInConnectedScenes: UIWindow? {
        return windows.first(where: { $0.isKeyWindow })
    }
}
