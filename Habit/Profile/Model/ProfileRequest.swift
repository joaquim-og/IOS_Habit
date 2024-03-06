//
//  ProfileRequest.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 06/03/24.
//

import Foundation

struct ProfileRequest: Encodable {
    
    let fullName: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case fullName = "name"
        case phone
        case birthday
        case gender
    }
    
}
