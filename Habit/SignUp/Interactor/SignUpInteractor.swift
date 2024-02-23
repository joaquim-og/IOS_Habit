//
//  SignUpInteractor.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 21/02/24.
//

import Foundation
import Combine

class SignUpInteractor {
    private let signUpRemoteDataSource: SignUpRemoteDataSource = SignUpRemoteDataSource.signUpRemoteDataSourceShared
    private let signInRemoteDataSource: SignInRemoteDataSource = SignInRemoteDataSource.signInRemoteDataSourceShared
    private let localDataSource: LocalDataSource = LocalDataSource.sharedLocalDataSource
}

extension SignUpInteractor {
    
    func signUp(request: SignUpRequest) -> Future<Bool, AppError> {
        
        return signUpRemoteDataSource.postUser(request: request)
    }
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
        return signInRemoteDataSource.login(request: request)
    }
    
    func insertAuth(userAuth: UserAuth) {
        localDataSource.insertUserAuth(userAuth: userAuth)
    }
}

