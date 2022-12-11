//
//  UserDetailsViewControllerTests.swift
//  LBGAssignmentUITests
//
//  Created by Nirosha Pabolu on 03/12/22.
//

import XCTest
@testable import LBGAssignment

class UserDetailsViewControllerStub: UserDetailsViewController { }

final class UserDetailsViewControllerTests: XCTestCase {
    var userDetailsVC: UserDetailsViewControllerStub!
    override func setUpWithError() throws {
        userDetailsVC = UserDetailsViewControllerStub()
        loadDataFromStub()
    }
    override func tearDownWithError() throws {
        userDetailsVC = nil
    }
    func loadDataFromStub() {
        userDetailsVC.userName = UILabel(frame: .zero)
        userDetailsVC.name = UILabel(frame: .zero)
        userDetailsVC.email = UILabel(frame: .zero)
        userDetailsVC.company = UILabel(frame: .zero)
        userDetailsVC.address = UILabel(frame: .zero)
        userDetailsVC.phone = UILabel(frame: .zero)
    }
    func testSetupUI() throws {
        userDetailsVC.user = User(id: 1,
                                   name: "Tom",
                                   username: "tom",
                                   email: "tom@gmail.com",
                                   address: Address(street: "Chiswell Street",
                                                    suite: "48",
                                                    city: "London",
                                                    zipcode: "E126NB",
                                                    geo: Geo(lat: "", lng: "")),
                                   phone: "+448080203420",
                                   website: "https://tom.com",
                                   company: Company(name: "Facebook",
                                                    catchPhrase: nil, business: nil))
        userDetailsVC.viewDidLoad()
        XCTAssertEqual(userDetailsVC.userName.text, "tom")
        XCTAssertEqual(userDetailsVC.name.text, "Tom")
        XCTAssertEqual(userDetailsVC.email.text, "tom@gmail.com")
        XCTAssertEqual(userDetailsVC.address.text, "London")
        XCTAssertEqual(userDetailsVC.phone.text, "+448080203420")
        XCTAssertEqual(userDetailsVC.company.text, "Facebook")
    }
    func testInvalidCompany() {
        userDetailsVC.user = User(id: 1,
                                   name: "Tom",
                                   username: "tom",
                                   email: "tom@gmail.com",
                                   address: Address(street: "Chiswell Street",
                                                    suite: "48",
                                                    city: "London",
                                                    zipcode: "E126NB",
                                                    geo: Geo(lat: "", lng: "")),
                                   phone: "+448080203420",
                                   website: "https://tom.com",
                                   company: nil)
        userDetailsVC.viewDidLoad()
        XCTAssertEqual(userDetailsVC.company.text, "")
    }
    func testInvalidUser() {
        userDetailsVC.viewDidLoad()
        XCTAssertNil(userDetailsVC.user)
    }
}
