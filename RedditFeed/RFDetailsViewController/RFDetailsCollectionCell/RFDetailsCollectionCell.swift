//
//  RFDetailsCollectionCell.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit

final class RFDetailsCollectionCell: UICollectionViewCell {
    @IBOutlet private weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
        }
    }
    
    var object: String? {
        didSet {
            imageView.setImageLazily(urlString: object)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
