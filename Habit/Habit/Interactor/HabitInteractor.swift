//
//  HabitInteractor.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 04/03/24.
//

import Foundation
import Combine

class HabitInteractor {
    private let remoteDataSource: HabitRemoteDataSource = HabitRemoteDataSource.habitRemoteDataSourceShared
    private let localDataSource: LocalDataSource = LocalDataSource.sharedLocalDataSource
}

extension HabitInteractor {
    
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        return remoteDataSource.fetchHabits()
    }
}
