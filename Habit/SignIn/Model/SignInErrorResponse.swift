//
//  File.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 21/02/24.
//

import Foundation

struct SignInErrorResponse: Decodable {
    
    let detail: SignInDetailErrorResponse?
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}

struct SignInDetailErrorResponse: Decodable {
    
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case message
    }
    
}
