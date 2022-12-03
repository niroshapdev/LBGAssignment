//
//  Constants.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation

struct Constants {
    static let UsersHomeScreenTitle = "Users"
    static let JailBrokenError = "This device is jail broken"
    static let SuccessAlert = "Success"
    static let Main = "Main"
    static let LoadingText = "Loading..."
    struct APIConstants {
        static let UsersListUrl = "https://jsonplaceholder.typicode.com/users"
    }
    struct TableViewIdentifiers {
        static let UserListIdentifier = "UserListCustomCell"
    }
    struct ViewControllerIdentifiers {
        static let UserDetailsViewControllerIdentifier = "UserDetailsViewController"
    }
    struct AccessibilityIdentifiers {
        static let UserListIdentifier = "UserListIdentifier"
    }
}
