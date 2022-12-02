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
    @IBOutlet weak var tableView: UITableView?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
        tableView?.dataSource = self
        updateUI()
    }
    private func initailizeCompletion() {
        viewModel.completion = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.hideActivityIndicator()
                if let error = self.viewModel.error {
                    self.showAlert(message: error.description())
                    return
                }
                self.tableView?.reloadData()
            }
        }
    }
    func updateUI() {
        self.navigationItem.title = Constants.UsersHomeScreenTitle
        self.showActivityIndicator()
        initailizeCompletion()
        viewModel.getUserList()
    }
}

extension UserListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.users?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let userCell = tableView.dequeueReusableCell(withIdentifier: Constants.TableViewIdentifiers.UserListIdentifier) as? UserListCustomCell
        else {
            return UITableViewCell()
        }
        userCell.nameLabel?.text = viewModel.users?[indexPath.row].name
        userCell.emailLabel?.text = viewModel.users?[indexPath.row].email
        return userCell
    }
}

extension UserListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let identifier = Constants.ViewControllerIdentifiers.UserDetailsViewControllerIdentifier
        guard let idvc: UserDetailsViewController = storyboard.instantiateViewController(withIdentifier: identifier) as? UserDetailsViewController,
              let user = viewModel.users?[indexPath.row]
        else { return }
        idvc.user = user
        show(idvc, sender: nil)
    }
}
