//
//  RFInitialViewControllerTests.swift
//  RedditFeedTests
//
//  Created by Rahul Garg on 14/12/21.
//

import XCTest
@testable import RedditFeed

class RFInitialViewControllerTests: XCTestCase {
    
    var initialVC: RFInitialViewController!

    override func setUp() {
        let storyboard = UIStoryboard(name: Storyboard.Name.main, bundle: nil)
        initialVC = storyboard.instantiateViewController(withIdentifier: RFInitialViewController.className) as? RFInitialViewController
    }
    
    override func tearDown() {
        initialVC = nil
        super.tearDown()
    }
    
    func testViewController() {
        XCTAssertNotNil(initialVC, "No View Controller Available")
    }
    
    func testShowFeedVC() {
        XCTAssertNotNil(initialVC.showFeedVC, "showFeedVC() error")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
