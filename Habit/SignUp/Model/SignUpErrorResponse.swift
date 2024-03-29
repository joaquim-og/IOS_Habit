//
//  SignUpErrorResponse.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 06/03/24.
//

import Foundation

struct SignUpErrorResponse: Decodable {
    
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
