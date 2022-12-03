//
//  BaseViewController.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 30/11/22.
//

import Foundation
import UIKit
import ProgressHUD

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func showActivityIndicator() {
        ProgressHUD.show(Constants.LoadingText)
    }
    func hideActivityIndicator() {
        ProgressHUD.dismiss()
    }
}
