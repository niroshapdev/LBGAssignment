//
//  UserListViewController.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation
import UIKit

class UserListViewController: BaseViewController {
    var viewModel = UserListViewModel()
    var users: Users = []
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        viewModel.delegate = self
        tableView?.accessibilityIdentifier = Constants.AccessibilityIdentifiers.UserListIdentifier
        navigationItem.title = Constants.UsersHomeScreenTitle
        updateUI()
    }
    private func updateUI() {
        self.showActivityIndicator()
        viewModel.getUserList()
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userCell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewIdentifiers.UserListIdentifier) as? UserListCustomCell
        else {
            return UITableViewCell()
        }
        let name = users[indexPath.row].name ?? ""
        let email = users[indexPath.row].email ?? ""
        userCell.accessibilityIdentifier = "userCell_\(indexPath.row)"
        userCell.configureCell(with: name, email: email)
        return userCell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: Constants.Main, bundle: .main)
        let identifier = Constants.ViewControllerIdentifiers.UserDetailsViewControllerIdentifier
        if let detailVC: UserDetailsViewController = storyboard.instantiateViewController(withIdentifier: identifier) as? UserDetailsViewController {
            detailVC.user = users[indexPath.row]
            show(detailVC, sender: nil)
        }
    }
}

extension UserListViewController: UserListViewModelDelegate {
    func requestDidSucceed(with users: Users) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.hideActivityIndicator()
            self.users = users
            self.tableView?.reloadData()
            Utils.showAlert(on: self, title: Constants.SuccessAlert, message: "Retrieved \(users.count) users from server")
        }
    }
    func requestDidFinishWithError(with error: APIError) {
        Utils.showAlert(on: self, message: error.description())
    }
}
