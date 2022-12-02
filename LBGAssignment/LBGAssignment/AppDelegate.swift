//
//  AppDelegate.swift
//  LBGAssignment
//
//  Created by Nirosha Pabolu on 30/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    func applicationDidBecomeActive (_ application: UIApplication) {
        if Utils.isJailBrokenDevice() {
            let jailBrokenView = UIViewController()
            jailBrokenView.view.frame = UIScreen.main.bounds
            jailBrokenView.view.backgroundColor = .white
            self.window?.rootViewController = jailBrokenView
            Utils.showAlert(on: jailBrokenView, message: Constants.JailBrokenError)
        }
    }
}
