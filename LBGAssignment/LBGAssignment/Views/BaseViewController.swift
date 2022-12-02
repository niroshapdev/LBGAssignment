//
//  BaseViewController.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 30/11/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    var activityIndicator = UIActivityIndicatorView(style: .large)

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func showActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    func hideActivityIndicator() {
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
    }
}
