//
//  SplashInteractor.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 22/02/24.
//

import Foundation
import Combine

class SplashInteractor {
    private let localDataSource: LocalDataSource = LocalDataSource.sharedLocalDataSource
}

extension SplashInteractor {
    
    func fetchAuth() -> Future<UserAuth?, Never> {
        return localDataSource.getUserAuth()
    }
    
}

