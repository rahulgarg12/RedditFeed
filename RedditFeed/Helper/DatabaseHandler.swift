//
//  DatabaseHandler.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import Foundation

import RealmSwift

final class DatabaseHandler {
    
    static let serialQueue = DispatchQueue(label: "com.realm.serial")
    
    static func clearRealmData() {
        let realm = try? Realm()
        try? realm?.write {
            DatabaseHandler.serialQueue.sync {
                realm?.deleteAll()
            }
        }
    }
}


extension DatabaseHandler {
    func saveNewBookmark(model: RFBookmarkModel) {
        autoreleasepool {
            let realm = try? Realm()
            try? realm?.write {
                if !model.isInvalidated {
                    DatabaseHandler.serialQueue.sync {
                        realm?.add(model)
                    }
                }
            }
        }
    }
    
    func getAllBookmarks() -> [RFBookmarkModel]? {
        autoreleasepool {
            let realm = try? Realm()

            if let result = realm?.objects(RFBookmarkModel.self) {
                return Array(result)
            } else {
                return nil
            }
        }
    }
    
    func getAllBookmarks() -> Results<RFBookmarkModel>? {
        autoreleasepool {
            let realm = try? Realm()
            
            let result = realm?.objects(RFBookmarkModel.self)
            return result
        }
    }
    
    func getBookmarkModel(for key: String?) -> RFBookmarkModel? {
        autoreleasepool {
            guard let key = key else { return nil }
            
            let realm = try? Realm()
            return realm?.object(ofType: RFBookmarkModel.self, forPrimaryKey: key)
        }
    }
    
    func deleteModel(for key: String?) {
        guard let model = getBookmarkModel(for: key) else { return }
        
        autoreleasepool {
            let realm = try? Realm()
            try? realm?.write {
                DatabaseHandler.serialQueue.sync {
                    realm?.delete(model)
                }
            }
        }
    }
    
    func perform(completion: () -> ()) {
        autoreleasepool {
            let realm = try? Realm()
            try? realm?.write {
                DatabaseHandler.serialQueue.sync {
                    completion()
                }
            }
        }
    }
}
