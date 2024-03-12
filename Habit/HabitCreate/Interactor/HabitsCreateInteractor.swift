//
//  HabitsCreateInteractor.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 12/03/24.
//

import Foundation
import Combine

class HabitsCreateInteractor {
    private let remoteDataSource: HabitsCreateRemoteDataSource = HabitsCreateRemoteDataSource.habitsCreateRemoteDataSourceShared
    private let localDataSource: LocalDataSource = LocalDataSource.sharedLocalDataSource
}

extension HabitInteractor {
    
//    func fetchHabits() -> Future<[HabitResponse], AppError> {
//        return remoteDataSource.fetchHabits()
//    }
}
