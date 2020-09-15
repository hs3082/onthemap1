//
//  StudentLocations.swift
//  OnTheMap
//
//  Created by Howard Snyder on 9/7/20.
//  Copyright © 2020 Howard Snyder. All rights reserved.
//

import Foundation

struct StudentLocations: Codable {
    
    let results: [StudentLocation]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}

class StudentsLocationData {
    
    static var studentsData = [StudentLocation]()
 
}
