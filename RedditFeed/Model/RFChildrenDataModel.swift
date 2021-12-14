//
//  RFChildrenDataModel.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import Foundation

final class RFChildrenDataModel: Codable {
    var id: String?
    var authorFullname: String?
    var title: String?
    var name: String?
    var thumbnail: String?
    var created: Double?
    var author: String?
    var url: String?
    var preview: RFPreviewModel?
    var totalAwardsReceived: Int?
    var score: Int?
    var numComments: Int?
    
    var isBookmark: Bool = false
    

    enum CodingKeys: String, CodingKey {
        case id
        case authorFullname = "author_fullname"
        case title
        case name
        case thumbnail
        case created
        case author
        case url
        case preview
        case totalAwardsReceived = "total_awards_received"
        case score
        case numComments = "num_comments"
    }
    
    init() {
        
    }
}
