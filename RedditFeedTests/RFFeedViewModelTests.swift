//
//  RFFeedViewModelTests.swift
//  RedditFeedTests
//
//  Created by Rahul Garg on 14/12/21.
//

import XCTest
@testable import RedditFeed

class RFFeedViewModelTests: XCTestCase {
    
    var viewModel: RFFeedViewModel!
    
    override func setUp() {
        super.setUp()
        
        viewModel = RFFeedViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testIsFetchMore() {
        XCTAssertNotNil(viewModel.isFetchMore(at: IndexPath(row: 2, section: 0)), "IsFetchMore error")
    }
    
    func testFilterContentForSearchText() {
        XCTAssertNotNil(viewModel.filterContentForSearchText("test"), "FilterContentForSearchText error")
    }
    
    func testFilterContentForSearchEmptyText() {
        XCTAssertNotNil(viewModel.filterContentForSearchText(""), "FilterContentForSearchText error")
    }

    func testPrefetchImages() {
        let ips = [IndexPath(row: 1, section: 1), IndexPath(row: 10, section: 0), IndexPath(row: 3, section: 1)]
        let data = [RFChildrenDataModel]()
        XCTAssertNotNil(viewModel.prefetchImages(at: ips, data: data), "prefetchImages(at: , data: ) error")
    }
    
    func testResponseApi() {
        var apiResponse: RFRedditModel?
        
        let exp = self.expectation(description: "myExpectation")
        
        let cancellable = viewModel.fetchData()
            .sink(receiveCompletion: { _ in }) { response in
                apiResponse = response
                exp.fulfill()
            }
        
        XCTAssertNotNil(cancellable, "Cancellable is nil")
        
        waitForExpectations(timeout: 10) { (error) in
            XCTAssertNotNil(apiResponse, "Response is nil")
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}



