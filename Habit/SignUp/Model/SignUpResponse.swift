//
//  SignUpResponse.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 20/02/24.
//

struct SignUpResponse: Decodable {
    
    let detail: String?
    
    enum CodingKeys: String, CodingKey {
        case detail
    }
    
}
