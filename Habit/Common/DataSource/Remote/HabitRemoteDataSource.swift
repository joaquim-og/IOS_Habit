//
//  HabitRemoteDataSource.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 04/03/24.
//

import Foundation
import Combine

class HabitRemoteDataSource {
    
    static var habitRemoteDataSourceShared = HabitRemoteDataSource()
    
    func fetchHabits() -> Future<[HabitResponse], AppError> {
        
        let decoder = JSONDecoder()
        
        return Future { promise in
            WebService.callJsonFormatWithoutBody(
                pathEnum: WebService.Endpoint.habits,
                method: WebService.RequestType.GET,
                onComplete: { result in
                    switch result {
                    case .failure(let error, let data):
                        if let errorData = data {
                            if error == .badRequest {
                                let responseError = try? decoder.decode(SignUpErrorResponse.self, from: errorData)
                                promise(.failure(AppError.response(message: responseError?.detail?.message ?? "Unknow server error")))
                            }
                        }
                        break
                    case .success(let data):
                        let response = try? decoder.decode([HabitResponse].self, from: data)
                        
                        guard let responseToEmit = response else {
                            debugPrint("Json Error parser response -> \(String(data: data, encoding: .utf8)!)")
                            return
                        }
                        
                        promise(.success(responseToEmit))
                        break
                    }
                }
            )
        }
    }
}
