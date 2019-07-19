//
//  OAuthSampleProjectTests.swift
//  OAuthSampleProjectTests
//
//  Created by Ashli Rankin on 7/17/19.
//  Copyright © 2019 Lickability. All rights reserved.
//

import XCTest
@testable import OAuthSampleProject

class OAuthSampleProjectTests: XCTestCase {
    
    func testRetrieveMeetupUser() {
       
        let accessToke = "f997b6f06f09fd96488846b9c5997036"
        let exp = expectation(description: "retrieve the user object from an endpoint")
        if let url = URL(string: "https://api.meetup.com/members/self") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "Get"
            urlRequest.addValue("-H Authorization: Bearer {\(accessToke)}", forHTTPHeaderField: "")
            URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    XCTFail("there was an error:\(error.localizedDescription)")
                }
                if let data = data {
                    do {
                        let user = try JSONDecoder().decode(MeetupUserModel.self, from: data)
                        print(user)
                       
                        XCTAssertEqual("ashilt", user.userName, "names are no equal")
                        exp.fulfill()
                    } catch {
                      XCTFail("could not retrieve data from URLRequest")
                    }
                }
  
            }.resume()
        }
        wait(for: [exp], timeout:3.0)
    }
}
