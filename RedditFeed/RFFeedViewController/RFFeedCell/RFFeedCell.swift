//
//  RFFeedCell.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit
import Combine

final class RFFeedCell: RFTableViewCell {
    //MARK: IBOutlets
    @IBOutlet weak var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.contentMode = .scaleAspectFill
            thumbnailImageView.layer.cornerRadius = 8
            thumbnailImageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    var object: RFChildrenDataModel? {
        didSet {
            titleLabel.text = object?.title
            timestampLabel.text = getFormattedTime(timestamp: object?.created)
            thumbnailImageView.setImageLazily(urlString: object?.thumbnail)
        }
    }
    
    //MARK: Overriden methods
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    //MARK: Helper methods
    private func getFormattedTime(timestamp: Double?) -> String? {
        guard let timestamp = timestamp else { return nil }
        
        let date = Date(timeIntervalSince1970: timestamp)
        return dateFormatter.string(from: date)
    }
}
