//
//  AccessTokenSucessModel.swift
//  OAuthSampleProject
//
//  Created by Ashli Rankin on 7/19/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

struct AccessTokenSucessModel:Codable{
    let accessToken: String
    let tokenType:String
    let expiresIn:Int
    let refreshToken:String
    
    private enum CodingKeys:String,CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
    }
    
}
