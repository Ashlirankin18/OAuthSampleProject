//
//  AppDelegate.swift
//  OAuthSampleProject
//
//  Created by Ashli Rankin on 7/17/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    MeetupAPIManager.shared.processOAuthStep1Response(url: url)
        return true
    }

}

