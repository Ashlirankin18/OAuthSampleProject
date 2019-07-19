//
//  AppError.swift
//  OAuthSampleProject
//
//  Created by Ashli Rankin on 7/19/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import Foundation

enum AppError: Error {
    case decodingError(String)
    case encodingError(String)
    case downloadingError(String)
    case uploadingError(String)
    case badURL(String)
}
