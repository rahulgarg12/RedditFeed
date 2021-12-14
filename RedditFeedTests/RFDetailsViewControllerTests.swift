//
//  RFDetailsViewControllerTests.swift
//  RedditFeedTests
//
//  Created by Rahul Garg on 14/12/21.
//

import XCTest
@testable import RedditFeed

class RFDetailsViewControllerTests: XCTestCase {
    
    var detailsVC: RFDetailsViewController!
    
    override func setUp() {
        super.setUp()
        
        let model = RFChildrenDataModel()
        model.id = "id"
        model.created = 1111111111
        model.title = "title"
        model.author = "author"
        model.thumbnail = "https://www.google.com"
        let viewModel = RFDetailsViewModel(model: model)
        
        let vc = RFDetailsViewController(nibName: RFDetailsViewController.className, bundle: nil)
        vc.viewModel = viewModel
        detailsVC = vc
    }
    
    override func tearDown() {
        detailsVC = nil
        super.tearDown()
    }
    
    func testViewController() {
        XCTAssertNotNil(detailsVC, "No View Controller Available")
    }
    
    func testViewModel() {
        XCTAssertNotNil(detailsVC.viewModel, "viewModel is nil")
    }
    
    func testNavigationBar() {
        XCTAssertNotNil(detailsVC.setNavigationBar(), "setNavigationBar() error")
    }
    
    func testSetBookmarkButton() {
        XCTAssertNotNil(detailsVC.setBookmarkButton(image: "bookmarkGrey"), "setBookmarkButton(image: ) error")
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}



