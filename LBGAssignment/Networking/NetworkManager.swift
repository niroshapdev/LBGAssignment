//
//  NetworkManager.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation

class NetworkManager: DataServiceProtocol {
    static let shared = NetworkManager()
    var endpoint: APIEndPoint?
    func getData <T: Decodable>(_ endpoint: APIEndPoint, type: T.Type, result: @escaping ((Result<T, APIError>) -> Void)) {
        let task = URLSession.shared.dataTask(with: endpoint.url) { (data, _, error) in
            guard let data = data else {
                result(.failure(APIError.invalidServerResponse))
                return
            }
            if let error = error {
                result(.failure(.custom(description: error.localizedDescription)))
                return
            }
            do {
                let parsedData = try JSONDecoder().decode(T.self, from: data)
                result(.success(parsedData))
            } catch {
                result(.failure(APIError.decodingError))
            }
        }
        task.resume()
    }
}
