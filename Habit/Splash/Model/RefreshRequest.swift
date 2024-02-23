//
//  RefreshRequest.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 23/02/24.
//

struct RefreshRequest: Encodable {
    
    let token: String
    
    enum CodingKeys: String, CodingKey {
        case token = "refresh_token"
    }
    
}
