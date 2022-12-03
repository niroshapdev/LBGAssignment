//
//  UserListViewModel.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation
import UIKit

class UserListViewModel {
    private var service: HTTPService
    private(set) var users: Users?
    private(set) var error: APIError?
    var completion: (() -> Void)?
    init(service: HTTPService = NetworkManager()) {
        self.service = service
    }
    func getUserList() {
        service.getData(EndPoint.users.getUrl(), type: Users.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                self.error = error
            }
            self.completion?()
        }
    }
}
