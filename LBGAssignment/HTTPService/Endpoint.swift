//
//  Endpoint.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation

enum EndPoint: String {
    case users
    func getUrl() -> String {
        switch self {
        case .users:
            return Constants.APIConstants.UsersListUrl
        }
    }
}
