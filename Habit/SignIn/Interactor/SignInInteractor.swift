//
//  SignInInteractor.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 21/02/24.
//

import Foundation
import Combine

class SignInInteractor {
    private let remoteDataSource: SignInRemoteDataSource = SignInRemoteDataSource.signInRemoteDataSourceShared
    private let localDataSource: LocalDataSource = LocalDataSource.sharedLocalDataSource
}

extension SignInInteractor {
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
        
        return remoteDataSource.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth) {
        localDataSource.insertUserAuth(userAuth: userAuth)
    }
}
