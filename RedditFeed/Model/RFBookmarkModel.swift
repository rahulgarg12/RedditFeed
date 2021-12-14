//
//  RFBookmarkModel.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import Foundation
import RealmSwift

final class RFBookmarkModel: Object, Codable {
    @objc dynamic var id: String = ""
    
    private enum CodingKeys: String, CodingKey {
        case id
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
