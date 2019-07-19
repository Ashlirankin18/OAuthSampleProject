//
//  MeetupDataHandler.swift
//  OAuthSampleProject
//
//  Created by Ashli Rankin on 7/19/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

class MeetupDataHandler {
    var accessToken:String?
    
    typealias Handler = (Result<MeetupUserModel,AppError>) -> Void
    
    func retrieveUserData(completionHandler: @escaping Handler) {
        guard let token = accessToken else {return}
        guard let url = URL(string: "https://api.meetup.com/members/self") else {
            completionHandler(.failure(.badURL("Could not create url from string")))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "Get"
        urlRequest.addValue("-H Authorization: Bearer {\(token)}", forHTTPHeaderField: "")
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                completionHandler(.failure(.downloadingError("An error was returned from the request")))
            }
            guard let data = data else {
                completionHandler(.failure(.downloadingError("No data was returned from request")))
                return
            }
            do {
                let user = try JSONDecoder().decode(MeetupUserModel.self, from: data)
               completionHandler(.success(user))
            } catch {
                completionHandler(.failure(.decodingError("Could not decode UserModel from data")))
            }
        }
        
    }
}
