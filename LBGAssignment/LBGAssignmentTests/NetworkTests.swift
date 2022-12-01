//
//  NetworkTests.swift
//  LBGAssignmentTests
//
//  Created by Nirosha Pabolu on 30/11/22.
//

import XCTest

final class NetworkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUsersFromNetwork() throws {
        let expectation = expectation(description: "Testing users from network")
        let viewModel = UserListViewModel()
        viewModel.completion = {
            expectation.fulfill()
            XCTAssertNotNil(viewModel.users)
            XCTAssertGreaterThan(viewModel.users?.count ?? 0, 0)
        }
        viewModel.getUserList()
        waitForExpectations(timeout: 5)
    }

}
