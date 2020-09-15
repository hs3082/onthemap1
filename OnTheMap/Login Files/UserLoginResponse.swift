//
//  UserLoginResponse.swift
//  OnTheMap
//
//  Created by Howard Snyder on 9/7/20.
//  Copyright © 2020 Howard Snyder. All rights reserved.
//

import Foundation

struct Session: Codable {
    let id: String
    let expiration: String
    enum CodingKeys: String, CodingKey { case id, expiration }
}

struct Account: Codable {
    let registered: Bool
    let key: String
    enum CodingKeys: String, CodingKey { case registered, key }
}

struct UserLoginResponse: Codable {
    let account: Account
    let session: Session
    enum CodingKeys: String, CodingKey { case account, session }
}






