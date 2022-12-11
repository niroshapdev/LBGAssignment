//
//  UserListViewModel.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation
import UIKit

protocol UserListViewModelDelegate: AnyObject {
    func requestDidSucceed(with users: Users)
    func requestDidFinishWithError(with error: APIError)
}
class UserListViewModel {
    private var dataService: DataServiceProtocol
    weak var delegate: UserListViewModelDelegate?
    init(service: DataServiceProtocol = NetworkManager()) {
        self.dataService = service
    }
    func getUserList() {
        dataService.getData(APIEndPoint(path: Constants.APIConstants.UsersListUrl), type: Users.self) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let users):
                self.delegate?.requestDidSucceed(with: users)
            case .failure(let error):
                self.delegate?.requestDidFinishWithError(with: error)
            }
        }
    }
}
