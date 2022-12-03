//
//  UserDetailsViewController.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation
import UIKit

class UserDetailsViewController: UIViewController {
    @IBOutlet var userName: UILabel!
    @IBOutlet var company: UILabel!
    @IBOutlet var address: UILabel!
    @IBOutlet var phone: UILabel!
    @IBOutlet var name: UILabel!
    @IBOutlet var email: UILabel!
    var user: User?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension UserDetailsViewController {
    private func setupUI() {
        if let user = user {
            self.navigationItem.title = user.username
            userName.text = user.username
            company.text = user.company?.name ?? ""
            phone.text = user.phone
            name.text = user.name
            email.text = user.email
            if let address = user.address {
                self.address.text = address.city
            }
        }
    }
}
