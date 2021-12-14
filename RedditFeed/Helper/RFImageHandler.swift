//
//  RFImageHandler.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import UIKit
import Kingfisher

struct RFImageHandler {
    func prefetch(urls: [String]) {
        let urls = urls.compactMap { URL(string: $0) }
        let prefetcher = ImagePrefetcher(urls: urls)
        prefetcher.start()
    }
}
