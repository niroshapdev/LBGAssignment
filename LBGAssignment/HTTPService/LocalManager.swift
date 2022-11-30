//
//  LocalManager.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 29/11/22.
//

import Foundation

enum JsonDataType {
    case empty, invalid, valid
    
    var getFileName: String {
        switch self {
        case .empty:
            return "Users_Empty"
        case .invalid:
            return "Users_Invalid"
        case .valid:
            return "Users"
        }
    }
}

class LocalManager: HTTPService {
    
    var jsonType: JsonDataType
    init(jsonType: JsonDataType) {
        self.jsonType = jsonType
    }
    
    func getData <T: Decodable>(_ endpoint: EndPoint, type: T.Type, result: @escaping ((Result<T, APIError>) -> Void)) {
        let urlStr = Bundle.main.url(forResource: jsonType.getFileName, withExtension: "json")
        guard let url = urlStr else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let parsedData = try JSONDecoder().decode(T.self, from: data)
            result(.success(parsedData))
        } catch APIError.noData {
            result(.failure(APIError.noData))
        } catch {
            result(.failure(APIError.custom(description: error.localizedDescription)))
        }
    }
}
