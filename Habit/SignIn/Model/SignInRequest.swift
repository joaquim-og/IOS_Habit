//
//  SignInRequest.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 21/02/24.
//

import Foundation

struct SignInRequest {
    
    let email: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
    }
    
}
