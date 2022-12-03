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
    func testInvalidUrl() throws {
        NetworkManager().getData("", type: User.self) { result in
            switch result {
            case .success(let success):
                XCTAssertNil(success)
            case .failure(let failure):
                XCTAssertNotNil(failure.description())
                XCTAssertEqual(failure, APIError.urlError)
            }
        }
    }
//    func testUsersFromNoNetwork() throws {
//        let expectation = expectation(description: "Testing users from network when no network")
//        let viewModel = UserListViewModel()
//        viewModel.completion = {
//            expectation.fulfill()
//            XCTAssertNil(viewModel.users)
//            XCTAssertNotNil(viewModel.error)
//        }
//        viewModel.getUserList()
//        waitForExpectations(timeout: 5)
//    }
    func testInvalidData() throws {
        NetworkManager().getData("https://google.com", type: User.self) { result in
            switch result {
            case .success(let success):
                XCTAssertNil(success)
            case .failure(let failure):
                XCTAssertNotNil(failure.description())
                XCTAssertEqual(failure, APIError.urlError)
            }
        }
    }
}
