//
//  RFRedditDataModel.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import Foundation

struct RFRedditDataModel: Codable {
    let after: String?
    let dist: Int?
    let modhash: String?
    var children: [RFChildrenModel]?
    let before: String?

    enum CodingKeys: String, CodingKey {
        case after, dist, modhash
        case children, before
    }
}
