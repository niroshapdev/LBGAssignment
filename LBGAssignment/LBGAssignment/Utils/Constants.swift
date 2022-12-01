//
//  Constants.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation

struct Constants {
    
    struct APIConstants {
        static let UsersListUrl = "https://jsonplaceholder.typicode.com/users"
    }
    
    struct TableViewIdentifiers {
        static let UserListIdentifier = "UserListCustomCell"
    }
    
    struct ViewControllerIdentifiers {
        static let UserDetailsViewControllerIdentifier = "UserDetailsViewController"
    }
}

enum APIError: Error, Equatable{
    case urlError
    case noData
    case custom(description: String)
    
    func description() -> String {
        switch self {
        case .urlError:
            return "URL Error"
        case .custom(let description):
            return "Custom Error : \(description)"
        case .noData:
            return "Error in retrieving the data"
        }
    }
}
