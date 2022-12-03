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

class LocalManager: HTTPService {
    var jsonType: JsonDataType
    init(jsonType: JsonDataType) {
        self.jsonType = jsonType
    }
    func getData <T: Decodable>(_ endpointUrl: String, type: T.Type, result: @escaping ((Result<T, APIError>) -> Void)) {
        guard let testBundle = Bundle(identifier: "com.tcs.LBGAssignmentTests"),
              let url = testBundle.url(forResource: jsonType.getFileName, withExtension: "json") else {
            result(.failure(APIError.custom(description: "Invalid URL")))
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            result(.success(parsedData))
        } catch APIError.noData {
            result(.failure(APIError.noData))
        } catch {
            if error is DecodingError {
                result(.failure(APIError.custom(description: "Decoding Error")))
            } else if error.localizedDescription == "The data couldn’t be read because it isn’t in the correct format." {
                result(.failure(APIError.noData))
            } else {
                result(.failure(APIError.custom(description: error.localizedDescription)))
            }
        }
    }
}
