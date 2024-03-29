//
//  ChartsInteractor.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 07/03/24.
//

import Foundation
import Combine

class ChartsInteractor {
    private let remoteDataSource: ChartsRemoteDataSource = ChartsRemoteDataSource.chartsRemoteDataSourceShared
    private let localDataSource: LocalDataSource = LocalDataSource.sharedLocalDataSource
}

extension ChartsInteractor {
    
    func fetchHabitValue(habitId: Int) -> Future<[HabitValueResponse], AppError> {
        return remoteDataSource.fetchHabitValue(habitId: habitId)
    }
    
}
