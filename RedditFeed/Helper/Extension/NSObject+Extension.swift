//
//  NSObject+Extension.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit

extension NSObject: ClassNameProtocol {
    var safeAreaBottom: CGFloat {
         if let window = UIApplication.shared.keyWindowInConnectedScenes {
            return window.safeAreaInsets.bottom
         }
         return 0
    }

    var safeAreaTop: CGFloat {
         if let window = UIApplication.shared.keyWindowInConnectedScenes {
            return window.safeAreaInsets.top
         }
         return 0
    }
}
