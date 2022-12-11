//
//  LocalManager.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 29/11/22.
//

import Foundation

enum JsonDataType {
    case empty, invalid, valid, noJson
    var getFileName: String {
        switch self {
        case .empty:
            return "Users_Empty"
        case .invalid:
            return "Users_Invalid"
        case .valid:
            return "Users"
        case .noJson:
            return "_"
        }
    }
}

struct MockUsers: Decodable {
    let user, userName: String
}

class LocalManager: DataServiceProtocol {
    var jsonType: JsonDataType
    init(jsonType: JsonDataType) {
        self.jsonType = jsonType
    }
    func getData <T: Decodable>(_ endpoint: APIEndPoint, type: T.Type, result: @escaping ((Result<T, APIError>) -> Void)) {
        let testBundle = Bundle(for: LocalManager.self)
        guard let url = testBundle.url(forResource: jsonType.getFileName, withExtension: "json") else {
            result(.failure(APIError.invalidUrl))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            result(.success(parsedData))
        } catch {
            if error is DecodingError {
                result(.failure(APIError.decodingError))
            } else {
                result(.failure(APIError.custom(description: error.localizedDescription)))
            }
        }
    }
}
