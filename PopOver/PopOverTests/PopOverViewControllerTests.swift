//
//  PopOverViewControllerTests.swift
//  PopOverTests
//
//  Created by Dipak Sonara on 15/05/21.
//

import XCTest

@testable import PopOver

class PopOverViewControllerTests: XCTestCase {

    var popoverVC: PopoverViewController!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        popoverVC = PopoverViewController()
        popoverVC.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        popoverVC = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableView() {
        popoverVC.items = [PopoverModel(text: "Option 1", value: 1, font: UIFont.systemFont(ofSize: 12), isSelected: false),PopoverModel(text: "Option 2", value: 1, font: UIFont.systemFont(ofSize: 12), isSelected: true)]
        XCTAssertNotNil(popoverVC.tableView)
        XCTAssertNotNil(popoverVC.tableView?.dataSource)
        XCTAssertNotNil(popoverVC.tableView?.delegate)
        XCTAssertEqual(popoverVC.tableView?.numberOfSections, 1)
        XCTAssertEqual(popoverVC.tableView?.numberOfRows(inSection: 0), popoverVC.items.count)
    }

}
