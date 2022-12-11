//
//  APIError.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 02/12/22.
//

import Foundation

enum APIError: Error, Equatable {
    case invalidUrl
    case invalidServerResponse
    case decodingError
    case custom(description: String)
    func description() -> String {
        switch self {
        case .invalidUrl:
            return "Invalid url"
        case .invalidServerResponse:
            return "Invalid server response"
        case .decodingError:
            return "Decoding Error"
        case .custom(let description):
            return description
        }
    }
}
