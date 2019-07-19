//
//  MeetupApiManager.swift
//  OAuthSampleProject
//
//  Created by Ashli Rankin on 7/17/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import UIKit
import SafariServices


class MeetupAPIManager {
    private init(){}
    
    static let shared = MeetupAPIManager()
    var completionHandler: ((Error?) -> Void)?
    
    var clientId = "pl35cjq6c05lqdjujqhb3tcggt"
    
    let clientSecret = "aj1bqb98cjk521h8t4il2473sr"
    
    var OAuthToken: String?
    
    
    let redirectURI = "deeplink://entry"
    
    func hasOAuthToken() -> Bool {
        return false
    }
    
    func startOAuth2Login() {
        let authPath = "https://secure.meetup.com/oauth2/authorize?client_id=\(clientId)&response_type=code&redirect_uri=\(redirectURI)"
        
        if let authURL = URL(string: authPath) {
            UIApplication.shared.open(authURL, options: [:], completionHandler: nil)
        }
    }
    
    func processOAuthStep1Response(url:URL){
        let components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var code:String?
        if let qureyItems = components?.queryItems {
            for qureyItem in qureyItems {
                if qureyItem.name.lowercased() == "code" {
                    code = qureyItem.value
                    break
                }
            }
        }
        if let receivedCode = code {
            let getTokenPath = "https://secure.meetup.com/oauth2/access"
            guard let newURL = URL(string: getTokenPath) else {return}
            var urlRequest = URLRequest(url: newURL)
            let dataBody = "client_id=\(clientId)&client_secret=\(clientSecret)&grant_type=authorization_code&redirect_uri=\(redirectURI)&code=\(receivedCode)"
            urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = dataBody.data(using: .utf8)
            urlRequest.httpMethod = "POST"
            URLSession.shared.dataTask(with: urlRequest) { (data, _, error) in
                if let error = error {
                    print("This is the error: \(error.localizedDescription)")
                }
                if let data = data {
                    do {
                        let sucess = try JSONDecoder().decode(AccessTokenSucessModel.self, from: data)
                        print(sucess)
                        
                    } catch {
                        do {
                            let failure = try JSONDecoder().decode(AccessTokenFailureModel.self, from: data)
                            print(failure)
                        } catch {
                            return
                        }
                        
                    }
                    
                }
                }.resume()
        }
    }
}

