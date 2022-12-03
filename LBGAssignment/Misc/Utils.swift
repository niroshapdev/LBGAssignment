//
//  Utils.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 02/12/22.
//

import UIKit

class Utils {
    static func showAlert(on controller: UIViewController, title: String = "Error", message: String, okAction: ((UIAlertAction) -> Void)? = nil) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: okAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { _ in
                controller.dismiss(animated: true)
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            controller.present(alertController, animated: true, completion: nil)
    }
    static func isJailBrokenDevice() -> Bool {
        if TARGET_IPHONE_SIMULATOR != 1 {
            // Check 1 : existence of files that are common for jailbroken devices
            if FileManager.default.fileExists(atPath: "/Applications/Cydia.app")
                || FileManager.default.fileExists(atPath: "/Library/MobileSubstrate/MobileSubstrate.dylib")
                || FileManager.default.fileExists(atPath: "/bin/bash")
                || FileManager.default.fileExists(atPath: "/usr/sbin/sshd")
                || FileManager.default.fileExists(atPath: "/etc/apt")
                || FileManager.default.fileExists(atPath: "/private/var/lib/apt/")
                || UIApplication.shared.canOpenURL(URL(string: "cydia://package/com.example.package")!) {
                return true
            }
            // Check 2 : Reading and writing in system directories (sandbox violation)
            let stringToWrite = "Jailbreak Test"
            do {
                try stringToWrite.write(toFile: "/private/JailbreakTest.txt", atomically: true, encoding: String.Encoding.utf8)
                // Device is jailbroken
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
    }
}
