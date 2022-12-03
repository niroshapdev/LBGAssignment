//
//  APIError.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 02/12/22.
//

import Foundation

enum APIError: Error, Equatable {
    case urlError
    case noData
    case custom(description: String)
    func description() -> String {
        switch self {
        case .urlError:
            return "URL Error"
        case .custom(let description):
            return description
        case .noData:
            return "Error in retrieving the data"
        }
    }
}
