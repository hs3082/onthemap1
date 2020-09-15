//
//  PostLocation.swift
//  OnTheMap
//
//  Created by Howard Snyder on 9/7/20.
//  Copyright © 2020 Howard Snyder. All rights reserved.
//

import Foundation

struct PostLocation: Codable {
    let uniqueKey: String
    let firstName: String
    let lastName: String
    let mapString: String
    let mediaURL: String
    let latitude: Float
    let longitude: Float
}

