//
//  LBGAssignmentTests.swift
//  LBGAssignmentTests
//
//  Created by Nirosha Pabolu on 30/11/22.
//

import XCTest
@testable import LBGAssignment

final class LBGAssignmentTests: XCTestCase {
    var userViewModel: UserListViewModel?
    var users: [User]?
    private let parseError = "The data couldn’t be read because it isn’t in the correct format."
    override func setUpWithError() throws {
        userViewModel = UserListViewModel(service: LocalManager(jsonType: .valid))
        userViewModel?.getUserList()
        users = userViewModel?.users
    }
    override func tearDownWithError() throws {
        userViewModel = nil
        users = nil
    }
    func testUsers() throws {
        guard let users = users else {
            XCTAssertNil(users)
            return
        }
        XCTAssertNotNil(users)
        XCTAssertGreaterThan(users.count, 0)
    }
    func testUserDetail() {
        users?.forEach { user in
            XCTAssertNotNil(user.id)
            XCTAssertNotNil(user.email)
        }
    }
    func testParticularUserDetail() {
        let user = users?.first
        XCTAssertEqual(user?.id ?? 0, 1)
        XCTAssertEqual(user?.email ?? "", "Nirosha@abc.com")
    }
    func testURL() {
        let urlStr = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: urlStr)
        XCTAssertEqual(url!.absoluteString, Constants.APIConstants.UsersListUrl)
    }
    func testInvalidURL() throws {
        let urlStr = ""
        XCTAssertNil(URL(string: urlStr))
    }
    func testInvalidJson() {
        let userViewModel = UserListViewModel(service: LocalManager(jsonType: .invalid))
        userViewModel.getUserList()
        let users = userViewModel.users
        XCTAssertNil(users)
        let error = userViewModel.error
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.description(), "Decoding Error")
    }
    func testEmptyJson() {
        let userViewModel = UserListViewModel(service: LocalManager(jsonType: .empty))
        userViewModel.getUserList()
        let users = userViewModel.users
        XCTAssertNil(users)
        let error = userViewModel.error
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.description(), "Decoding Error")
    }
    func testNoJson() {
        let userViewModel = UserListViewModel(service: LocalManager(jsonType: .noJson))
        userViewModel.getUserList()
        let error = userViewModel.error
        XCTAssertNotNil(error)
        XCTAssertEqual(error?.description(), "Invalid URL")
    }
    func testInvalidUsers() throws {
        let manager = LocalManager(jsonType: .valid)
        manager.getData(manager.jsonType.getFileName, type: MockUsers.self) { result in
            switch result {
            case .success(let success):
                XCTAssertNil(success)
            case .failure(let failure):
                XCTAssertNotNil(failure.localizedDescription)
                XCTAssertEqual(failure, APIError.custom(description: "Decoding Error"))
            }
        }
    }
}
