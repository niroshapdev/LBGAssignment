//
//  HTTPService.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 05/12/22.
//

import Foundation

protocol HTTPService {
    func getData <T: Decodable>(_ endpointUrl: String, type: T.Type, result: @escaping ((Result<T, APIError>) -> Void))
}
