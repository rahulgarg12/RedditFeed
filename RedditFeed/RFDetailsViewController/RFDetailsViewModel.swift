//
//  RFDetailsViewModel.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import Foundation

final class RFDetailsViewModel {
    private var model: RFChildrenDataModel?
    
    private var imagesUrl = [String]()
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    var title: String? {
        return model?.title
    }
    
    var authorName: String? {
        return model?.author
    }
    
    var createdAt: String? {
        guard let created = model?.created else { return nil }
        
        let date = Date(timeIntervalSince1970: created)
        return dateFormatter.string(from: date)
    }
    
    var awards: String? {
        return "\(model?.totalAwardsReceived ?? 0)"
    }
    
    var score: String? {
        return "\(model?.score ?? 0)"
    }
    
    var commentsCount: String? {
        return "\(model?.numComments ?? 0)"
    }
    
    var images: [String] {
        return imagesUrl
    }
    
    init(model: RFChildrenDataModel?) {
        self.model = model
        
        for image in model?.preview?.images ?? [] {
            guard let url = image.resolutions?.last?.url?.replacingOccurrences(of: "&amp;", with: "&"),
                    !url.isEmpty
                else { continue }
            
            imagesUrl.append(url)
        }
        
        if imagesUrl.isEmpty, let thumbnail = model?.thumbnail, !thumbnail.isEmpty {
            imagesUrl.append(thumbnail)
        }
    }
    
    func isBookmarked() -> Bool {
        guard let id = model?.id else { return false }
        
        if let _ = DatabaseHandler().getBookmarkModel(for: id) {
            return true
        } else {
            return false
        }
    }
    
    func saveBookmark() {
        guard let id = model?.id else { return }
        
        let bookmarkModel = RFBookmarkModel()
        bookmarkModel.id = id
        
        DatabaseHandler().saveNewBookmark(model: bookmarkModel)
    }
    
    func deleteBookmark() {
        guard let id = model?.id else { return }
        
        DatabaseHandler().deleteModel(for: id)
    }
    
    func prefetchImages(at indexPaths: [IndexPath]) {
        let urls: [String] = indexPaths.compactMap {
            guard imagesUrl.count > $0.item else { return nil}

            return imagesUrl[$0.item]
        }

        RFImageHandler().prefetch(urls: urls)
    }
}
