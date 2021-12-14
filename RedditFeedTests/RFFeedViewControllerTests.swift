//
//  RFFeedViewControllerTests.swift
//  RedditFeedTests
//
//  Created by Rahul Garg on 14/12/21.
//

import XCTest
@testable import RedditFeed

class RFFeedViewControllerTests: XCTestCase {
    
    var feedVC: RFFeedViewController!
    
    override func setUp() {
        super.setUp()
        
        let vc = RFFeedViewController(nibName: RFFeedViewController.className, bundle: nil)
        vc.viewModel = RFFeedViewModel()
        feedVC = vc
    }
    
    override func tearDown() {
        feedVC = nil
        super.tearDown()
    }
    
    func testViewController() {
        XCTAssertNotNil(feedVC, "No View Controller Available")
    }
    
    func testViewModel() {
        XCTAssertNotNil(feedVC.viewModel, "viewModel is nil")
    }
    
    func testShowSpinner() {
        XCTAssertNotNil(feedVC.showSpinner(), "showSpinner() error")
    }
    
    func testStopSpinner() {
        XCTAssertNotNil(feedVC.stopSpinner(), "stopSpinner() error")
    }
    
    func testActivityIndicator() {
        XCTAssertNotNil(feedVC.spinner, "Activity Indicator is nil")
    }
    
    func testSearchController() {
        XCTAssertNotNil(feedVC.searchController, "Search Controller is nil")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}


