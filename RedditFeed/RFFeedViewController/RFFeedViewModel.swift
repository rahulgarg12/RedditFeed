//
//  RFFeedViewModel.swift
//  RedditFeed
//
//  Created by Rahul Garg on 14/12/21.
//

import Foundation
import Combine

final class RFFeedViewModel {
    
    lazy var isLastPageReached = false
    lazy var isAPIInProgress = false
    lazy var pageAfter = ""
    
    @Published var feed: RFRedditModel?
    var data = [RFChildrenDataModel]()
    var filteredData = [RFChildrenDataModel]()
    
    
    //MARK: Network Handlers
    func fetchData() -> AnyPublisher<RFRedditModel, Error> {
        guard let urlComponents = URLComponents(string: "\(APIs.feed)\(Network.APIKey.after)=\(pageAfter)") else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        guard let url = urlComponents.url else {
            let error = URLError(.badURL)
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.get.rawValue
        
        return NetworkHandler().run(request)
            .map(\.value)
            .eraseToAnyPublisher()
    }
    
    func isFetchMore(at indexPath: IndexPath) -> Bool {
        if !data.isEmpty,
            data.count - 5 == indexPath.item,
            isAPIInProgress == false,
            isLastPageReached == false {
            return true
        } else {
            return false
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        filteredData = data.filter { (model: RFChildrenDataModel) -> Bool in
            if searchText.isEmpty {
                return true
            } else {
                return model.title?.lowercased().contains(searchText.lowercased()) ?? false
            }
        }
    }
    
    func prefetchImages(at indexPaths: [IndexPath], data: [RFChildrenDataModel]) {
        let urls: [String] = indexPaths.compactMap {
            guard data.count > $0.row else { return nil }

            return data[$0.row].thumbnail
        }

        RFImageHandler().prefetch(urls: urls)
    }
}

