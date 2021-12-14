//
//  RFTableViewCell.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit
import Combine

class RFTableViewCell: UITableViewCell {
    var cancellables = Set<AnyCancellable>()
    
    var indexPath: IndexPath?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cancellables = Set<AnyCancellable>()
    }
}

