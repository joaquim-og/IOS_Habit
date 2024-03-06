//
//  ProfileRemoteDataSource.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 05/03/24.
//

import Foundation
import Combine

class ProfileRemoteDataSource {
    
    static var profileRemoteDataSourceShared = ProfileRemoteDataSource()
    
//    func saveHabitValue(habitId: Int, request: HabitDetailsValueRequest) -> Future<Bool, AppError> {
//        
//        let decoder = JSONDecoder()
//        let pathFormatted = WebService.buildPathString(path: WebService.Endpoint.habitsValues, idToUpdate: habitId)
//        
//        return Future { promise in
//            WebService.callJsonFormat(
//                pathString: pathFormatted,
//                method: WebService.RequestType.POST,
//                body: request,
//                onComplete: { result in
//                    switch result {
//                    case .failure(let error, let data):
//                        if let errorData = data {
//                            if error == .badRequest {
//                                let responseError = try? decoder.decode(SignUpErrorResponse.self, from: errorData)
//                                promise(.failure(AppError.response(message: responseError?.detail?.message ?? "Unknow server error")))
//                            }
//                        }
//                        break
//                    case .success(_):
//                        promise(.success(true))
//                        break
//                    }
//                }
//            )
//        }
//    }
}
