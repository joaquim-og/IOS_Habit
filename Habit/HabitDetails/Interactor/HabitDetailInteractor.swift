//
//  HabitDetailInteractor.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 04/03/24.
//

import Foundation
import Combine

class HabitDetailInteractor {
    private let remoteDataSource: HabitDetailRemoteDataSource = HabitDetailRemoteDataSource.habitDetailRemoteDataSourceShared
    private let localDataSource: LocalDataSource = LocalDataSource.sharedLocalDataSource
}

extension HabitDetailInteractor {
    
    func saveHabitValue(habitId: Int, request: HabitDetailsValueRequest) -> Future<Bool, AppError> {
        return remoteDataSource.saveHabitValue(habitId: habitId, request: request)
    }
    
}
