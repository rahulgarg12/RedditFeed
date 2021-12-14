//
//  RFDetailsViewModelTests.swift
//  RedditFeedTests
//
//  Created by Rahul Garg on 14/12/21.
//

import XCTest
@testable import RedditFeed

class RFDetailsViewModelTests: XCTestCase {
    
    var viewModel: RFDetailsViewModel!
    
    override func setUp() {
        super.setUp()
        
        let model = RFChildrenDataModel()
        model.id = "id"
        model.created = 1111111111
        model.title = "title"
        model.author = "author"
        model.thumbnail = "https://www.google.com"
        viewModel = RFDetailsViewModel(model: model)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testTitle() {
        XCTAssertNotNil(viewModel.title, "title error")
    }
    
    func testAuthorName() {
        XCTAssertNotNil(viewModel.authorName, "authorName error")
    }
    
    func testCreatedAt() {
        XCTAssertNotNil(viewModel.createdAt, "createdAt error")
    }
    
    func testScore() {
        XCTAssertNotNil(viewModel.score, "score error")
    }
    
    func testCommentsCount() {
        XCTAssertNotNil(viewModel.commentsCount, "commentsCount error")
    }
    
    func testAwards() {
        XCTAssertNotNil(viewModel.awards, "awards error")
    }
    
    func testImages() {
        XCTAssertNotNil(viewModel.images, "images error")
    }
    
    func testIsBookmarked() {
        XCTAssertNotNil(viewModel.isBookmarked, "isBookmarked error")
    }
    
    func testSaveBookmark() {
        XCTAssertNotNil(viewModel.saveBookmark, "saveBookmark error")
    }
    
    func testDeleteBookmark() {
        XCTAssertNotNil(viewModel.deleteBookmark, "deleteBookmark error")
    }

    func testPrefetchImages() {
        let ips = [IndexPath(row: 1, section: 1), IndexPath(row: 10, section: 0), IndexPath(row: 3, section: 1)]
        XCTAssertNotNil(viewModel.prefetchImages(at: ips), "prefetchImages(at:) error")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}



