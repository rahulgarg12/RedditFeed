//
//  RFImageModel.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import Foundation

struct RFImageModel: Codable {
    let source: RFImageSourceModel?
    let resolutions: [RFImageSourceModel]?
    let id: String?
}
