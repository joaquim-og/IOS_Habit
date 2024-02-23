//
//  LocalDataSource.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 22/02/24.
//

import Foundation
import Combine

class LocalDataSource {
    
    static var sharedLocalDataSource: LocalDataSource = LocalDataSource()
    
    enum DataSourceKeys: String {
        case USER_KEY = "user_key"
    }
    
    private func saveValue(value: UserAuth) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(value), forKey: DataSourceKeys.USER_KEY.rawValue)
    }
    
    private func readValue(key: String) -> UserAuth? {
        var userAuth: UserAuth?
        
        if let data = UserDefaults.standard.value(forKey: key) as? Data {
            userAuth = try? PropertyListDecoder().decode(UserAuth.self, from: data)
        }
        
        return userAuth
    }
    
}

extension LocalDataSource {
    
    func insertUserAuth(userAuth: UserAuth) {
        saveValue(value: userAuth)
    }
    
    func getUserAuth() -> Future<UserAuth?, Never> {
        let userAuth = readValue(key: DataSourceKeys.USER_KEY.rawValue)
        
        return Future { promise in
            promise(.success(userAuth))
        }
    }
    
}
