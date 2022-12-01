//
//  UserDetailsViewController.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation
import UIKit

class UserDetailsViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var company: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var phone: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var email: UILabel!
    
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

extension UserDetailsViewController {
    func setupUI() {
        guard let user = user else { return }
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
