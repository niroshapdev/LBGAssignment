//
//  NetworkTests.swift
//  LBGAssignmentTests
//
//  Created by Nirosha Pabolu on 30/11/22.
//

import XCTest

final class NetworkTests: XCTestCase {
    var networkExpectation: XCTestExpectation?
    var users: Users?
    var error: APIError?
    override func setUpWithError() throws {
    }
    func testUsersFromNetwork() throws {
        networkExpectation = expectation(description: "Testing users from network")
        let viewModel = UserListViewModel()
        viewModel.delegate = self
        viewModel.getUserList()
        waitForExpectations(timeout: 5)
    }
    func testInvalidUrl() throws {
        NetworkManager().getData(APIEndPoint(path: ""), type: User.self) { result in
            switch result {
            case .success(let success):
                XCTAssertNil(success)
            case .failure(let failure):
                XCTAssertNotNil(failure.description())
            }
        }
    }
    func testInvalidData() throws {
        NetworkManager().getData(APIEndPoint(path: "UsersInvalid"), type: User.self) { result in
            switch result {
            case .success(let success):
                XCTAssertNil(success)
            case .failure(let failure):
                XCTAssertNotNil(failure.description())
                XCTAssertEqual(failure, APIError.decodingError)
            }
        }
    }
}

extension NetworkTests: UserListViewModelDelegate {
    func requestDidSucceed(with users: Users) {
        self.users = users
        networkExpectation?.fulfill()
        XCTAssertNotNil(users)
        XCTAssertGreaterThan(users.count, 0)
    }
    func requestDidFinishWithError(with error: APIError) {
        self.error = error
        networkExpectation?.fulfill()
        XCTAssertNotNil(error)
    }
}
