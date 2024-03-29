//
//  ChartsRemoteDataSource.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 07/03/24.
//

import Foundation
import Combine

class ChartsRemoteDataSource {
    
    static var chartsRemoteDataSourceShared = ChartsRemoteDataSource()
    
    func fetchHabitValue(habitId: Int) -> Future<[HabitValueResponse], AppError> {
        
        let decoder = JSONDecoder()
        let pathFormatted = WebService.buildPathString(path: WebService.Endpoint.habitsValues, idToUpdate: habitId)
        
        return Future { promise in
            WebService.callJsonFormatWithoutBody(
                pathString: pathFormatted,
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
                        let response = try? decoder.decode([HabitValueResponse].self, from: data)
                        
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
