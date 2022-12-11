//
//  HTTPService.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 05/12/22.
//

import Foundation

protocol DataServiceProtocol {
    func getData <T: Decodable>(_ endpoint: APIEndPoint, type: T.Type, result: @escaping ((Result<T, APIError>) -> Void))
}
