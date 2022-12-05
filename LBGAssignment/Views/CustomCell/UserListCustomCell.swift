//
//  UserListCustomCell.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 28/11/22.
//

import Foundation
import UIKit

class UserListCustomCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    func configureCell(with name: String, email: String) {
        self.nameLabel.text = name
        self.emailLabel.text = email
    }
}
