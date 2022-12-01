//
//  NetworkManager.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation

protocol HTTPService {
    func getData <T: Decodable>(_ endpoint: EndPoint, type: T.Type, result: @escaping ((Result<T, APIError>) -> Void))
}

class NetworkManager: HTTPService {
    static let shared = NetworkManager()
           
    func getData <T: Decodable>(_ endpoint: EndPoint, type: T.Type, result: @escaping ((Result<T, APIError>) -> Void)) {
        
        guard let url = URL(string: endpoint.getUrl()) else {
            result(.failure(APIError.urlError))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                result(.failure(APIError.noData))
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
                result(.failure(.custom(description: error.localizedDescription)))
            }
        }
        task.resume()
    }
}
