//
//  SplashInteractor.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 22/02/24.
//

import Foundation
import Combine

class SplashInteractor {
    
    private let remoteDataSource: SplashRemoteDataSource = SplashRemoteDataSource.splashRemoteDataSourceShared
    private let localDataSource: LocalDataSource = LocalDataSource.sharedLocalDataSource    
}

extension SplashInteractor {
    
    func fetchAuth() -> Future<UserAuth?, Never> {
        return localDataSource.getUserAuth()
    }
    
    func refreshToken(request: RefreshRequest) -> Future<SignInResponse, AppError> {
        return remoteDataSource.refreshToken(request: request)
    }
    
    func insertAuth(userAuth: UserAuth) {
        localDataSource.insertUserAuth(userAuth: userAuth)
    }
    
}

