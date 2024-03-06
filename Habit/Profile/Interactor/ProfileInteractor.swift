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
    
//    func saveHabitValue(habitId: Int, request: HabitDetailsValueRequest) -> Future<Bool, AppError> {
//        return remoteDataSource.saveHabitValue(habitId: habitId, request: request)
//    }
    
}
