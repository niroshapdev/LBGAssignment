//
//  Utils.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 02/12/22.
//

import UIKit

class Utils {
   static func showAlert(on controller: UIViewController, message: String, okAction: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: okAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { _ in
            controller.dismiss(animated: true)
        }
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
    }
}
