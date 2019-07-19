//
//  ViewController.swift
//  OAuthSampleProject
//
//  Created by Ashli Rankin on 7/17/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    let apiManager = MeetupAPIManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        loadInitialData()
    }
 
    func loadInitialData(){
        if (!apiManager.hasOAuthToken()) {
            apiManager.startOAuth2Login()
        } else {
            fetchMyGroups()
        }
    }
    func fetchMyGroups() {
        MeetupDataHandler().retrieveUserData() { (results) in
            switch results {
            case .failure(let error):
                print(error)
            case .success(let user):
                print(user)
            }
        }
    }
    
    func requestIsFinished(){
//        apiManager.completionHandler = {
//            (error) -> Void in
//            print("handlin stuff")
//            if let receivedError = error
//            {
//                print(receivedError)
//                // TODO: handle error
//                // Something went wrong, try again
//                self.apiManager.startOAuth2Login()
//            }
//            else
//            {
//                self.fetchMyGroups()
//            }
//        }
    }
}

