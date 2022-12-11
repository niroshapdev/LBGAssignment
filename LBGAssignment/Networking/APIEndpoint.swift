//
//  Endpoint.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation

struct APIEndPoint {
    let baseUrl: String
    let path: String
    static var defaultBaseUrl: String {
        return Constants.APIConstants.BaseUrl
    }
    var url: URL {
        var components = URLComponents(string: baseUrl)!
        components.path = APIEndPoint.defaultBaseUrl.appending(self.path)
        return URL(string: components.path)!
    }
    init(baseUrl: String = APIEndPoint.defaultBaseUrl, path: String) {
        self.baseUrl = baseUrl
        self.path = path
    }
}
