//
//  ProfileResponse.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 06/03/24.
//

import Foundation

struct ProfileResponse: Decodable {
    
    let id: Int
    let fullName: String
    let email: String
    let document: String
    let phone: String
    let birthday: String
    let gender: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName = "name"
        case email
        case document
        case phone
        case birthday
        case gender
    }
    
}
