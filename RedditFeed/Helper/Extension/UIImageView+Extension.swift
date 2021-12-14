//
//  UIImageView+Extension.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImageLazily(urlString: String?, placeholderNamed: String = "redditLogo") {
        if let urlString = urlString, let url = URL(string: urlString) {
            self.kf.setImage(with: url, placeholder: UIImage(named: placeholderNamed))
        } else {
            self.image = UIImage(named: placeholderNamed)
        }
    }
}
