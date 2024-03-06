//
//  SignUpErrorResponse.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 21/02/24.
//

import Foundation

struct ErrorResponse: Decodable {
    
    let detail: SignUpDetailErrorResponse?
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}

struct SignUpDetailErrorResponse: Decodable {
    
    let message: String?
    
    enum CodingKeys: String, CodingKey {
        case message
    }
    
}
