//
//  ProfileInteractor.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 05/03/24.
//

import Foundation
import Combine

class ProfileInteractor {
    private let remoteDataSource: ProfileRemoteDataSource = ProfileRemoteDataSource.profileRemoteDataSourceShared
    private let localDataSource: LocalDataSource = LocalDataSource.sharedLocalDataSource
}

extension ProfileInteractor {
    
    func fetchUser() -> Future<ProfileResponse, AppError> {
        return remoteDataSource.fetchUser()
    }
    
    func updateUser(userId: Int, request: ProfileRequest) -> Future<ProfileResponse, AppError> {
        return remoteDataSource.updateUser(userId: userId, request: request)
    }
    
}
