//
//  LBGAssignmentUITests.swift
//  LBGAssignmentUITests
//
//  Created by Nirosha Pabolu on 02/12/22.
//

import XCTest
@testable import LBGAssignment

final class LBGAssignmentUITests: XCTestCase {
    let app = XCUIApplication()
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    func testNavigation() {
        let myTable = app.tables.matching(identifier: "UserListIdentifier")
        let cell = myTable.cells.element(matching: .cell, identifier: "userCell_0")
        cell.tap()
    }
    func testUserDetailView() {
        let myTable = app.tables.matching(identifier: "UserListIdentifier")
        let cell = myTable.cells.element(matching: .cell, identifier: "userCell_0")
        cell.tap()
        XCTAssert(app.staticTexts["Bret"].exists)
        XCTAssert(app.staticTexts["Romaguera-Crona"].exists)
        XCTAssert(app.staticTexts["Gwenborough"].exists)
        XCTAssert(app.staticTexts["1-770-736-8031 x56442"].exists)
        XCTAssert(app.staticTexts["Leanne Graham"].exists)
        XCTAssert(app.staticTexts["Sincere@april.biz"].exists)
    }
}
