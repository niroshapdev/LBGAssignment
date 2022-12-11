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
    var users: Users?
    var error: APIError?
    var currentJSONType: JsonDataType = .valid
    private let parseError = "The data couldn’t be read because it isn’t in the correct format."
    override func setUpWithError() throws {
    }
    override func tearDownWithError() throws {
        userViewModel = nil
        users = nil
    }
    func testUsers() throws {
        userViewModel = UserListViewModel(service: LocalManager(jsonType: .valid))
        userViewModel?.delegate = self
        userViewModel?.getUserList()
    }
    func testUserDetail() {
        userViewModel = UserListViewModel(service: LocalManager(jsonType: .valid))
        userViewModel?.delegate = self
        userViewModel?.getUserList()
        users?.forEach { user in
            XCTAssertNotNil(user.id)
            XCTAssertNotNil(user.email)
        }
    }
    func testParticularUserDetail() {
        userViewModel = UserListViewModel(service: LocalManager(jsonType: .valid))
        userViewModel?.delegate = self
        userViewModel?.getUserList()
        let user = users?.first
        XCTAssertEqual(user?.id ?? 0, 1)
        XCTAssertEqual(user?.email ?? "", "Nirosha@abc.com")
    }
    func testURL() {
        let urlStr = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: urlStr)
        guard let endpoint = URL(string: "\(APIEndPoint.users.url)")  else { return }
        XCTAssertEqual(url, endpoint )
    }
    func testInvalidURL() throws {
        let urlStr = ""
        XCTAssertNil(URL(string: urlStr))
    }
    func testInvalidJson() {
        let userViewModel = UserListViewModel(service: LocalManager(jsonType: .invalid))
        userViewModel.delegate = self
        currentJSONType = .invalid
        userViewModel.getUserList()
    }
    func testEmptyJson() {
        let userViewModel = UserListViewModel(service: LocalManager(jsonType: .empty))
        userViewModel.delegate = self
        currentJSONType = .empty
        userViewModel.getUserList()
    }
    func testNoJson() {
        let userViewModel = UserListViewModel(service: LocalManager(jsonType: .noJson))
        userViewModel.delegate = self
        currentJSONType = .noJson
        userViewModel.getUserList()
    }
    func testInvalidUsers() throws {
        let manager = LocalManager(jsonType: .valid)
        manager.getData(APIEndPoint(path: manager.jsonType.getFileName), type: MockUsers.self) { result in
            switch result {
            case .success(let success):
                XCTAssertNil(success)
            case .failure(let failure):
                XCTAssertNotNil(failure.localizedDescription)
                XCTAssertEqual(failure, APIError.decodingError)
            }
        }
    }
}

extension LBGAssignmentTests: UserListViewModelDelegate {
    func requestDidSucceed(with users: Users) {
        self.users = users
        XCTAssertNotNil(users)
        XCTAssertGreaterThan(users.count, 0)
    }
    func requestDidFinishWithError(with error: APIError) {
        self.error = error
        switch currentJSONType {
        case .invalid, .empty:
            XCTAssertNil(users)
            XCTAssertNotNil(error)
            XCTAssertEqual(error.description(), "Decoding Error")
        case .noJson:
            XCTAssertNotNil(error)
            XCTAssertEqual(error.description(), "Invalid url")
        default:
            break
        }
    }
}
