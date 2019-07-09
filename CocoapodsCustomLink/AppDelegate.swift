//
//  AppDelegate.swift
//  CocoapodsCustomLink
//
//  Created by 小島徹也 on 2019/07/05.
//  Copyright © 2019 com.kotalab. All rights reserved.
//

import UIKit
import EmbeddedFramework

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ViewController.instantiate()
        window?.makeKeyAndVisible()

        Firebase.setup()
        return true
    }
}

