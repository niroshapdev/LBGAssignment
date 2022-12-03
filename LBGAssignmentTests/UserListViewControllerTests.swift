//
//  UtilityTests.swift
//  LBGAssignmentTests
//
//  Created by Nirosha Pabolu on 03/12/22.
//

import XCTest
@testable import LBGAssignment

class UserListViewControllerTests: XCTestCase {
    var controller: UserListViewController!
    override func setUp() {
        super.setUp()
        controller = UserListViewController()
        self.controller.loadView()
        self.controller.tableView = UITableView(frame: .zero)
        self.controller.viewDidLoad()
    }
    override func tearDown() {
        super.tearDown()
        controller = nil
    }
    func testHasATableView() {
        XCTAssertNotNil(controller.tableView)
    }
    func testTableViewHasDelegate() {
        XCTAssertNotNil(controller.tableView?.delegate)
    }
    func testTableViewConfromsToTableViewDelegateProtocol() {
        XCTAssertTrue(controller.conforms(to: UITableViewDelegate.self))
        XCTAssertTrue(controller.responds(to: #selector(controller.tableView(_:didSelectRowAt:))))
    }
    func testTableViewHasDataSource() {
        XCTAssertNotNil(controller.tableView?.dataSource)
    }
    func testTableViewConformsToTableViewDataSourceProtocol() {
        XCTAssertTrue(controller.conforms(to: UITableViewDataSource.self))
        XCTAssertTrue(controller.responds(to: #selector(controller.tableView(_:numberOfRowsInSection:))))
        XCTAssertTrue(controller.responds(to: #selector(controller.tableView(_:cellForRowAt:))))
    }
}
