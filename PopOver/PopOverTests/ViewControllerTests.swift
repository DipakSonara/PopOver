//
//  ViewControllerTests.swift
//  PopOverTests
//
//  Created by Dipak Sonara on 02/05/21.
//

import XCTest

@testable import PopOver

class ViewControllerTests: XCTestCase {

    var homeVC: ViewController!

    override func setUpWithError() throws {
        homeVC =
            ViewControllerInstance.fromStoryboard(Storyboard.main, identifier: Storyboard.Identifier.homeVC) as? ViewController
        homeVC.loadView()
    }
    
    func testControllsNotNil(){
        XCTAssertNotNil(self.homeVC.tableView)
    }

    override func tearDownWithError() throws {
        homeVC = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
