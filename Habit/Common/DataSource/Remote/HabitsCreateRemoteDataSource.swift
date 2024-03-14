//
//  HabitsCreateRemoteDataSource.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 12/03/24.
//

import Foundation
import Combine

class HabitsCreateRemoteDataSource {
    
    static var habitsCreateRemoteDataSourceShared = HabitsCreateRemoteDataSource()
    
    func save(request: HabitCreateRequest) -> Future<Void, AppError> {
        let decoder = JSONDecoder()
        
        return Future<Void, AppError> { promise in
            WebService.callFormDataFormat(
                path: WebService.Endpoint.habits,
                method: WebService.RequestType.POST,
                params: [
                    URLQueryItem(name: "name", value: request.name),
                    URLQueryItem(name: "label", value: request.label)
                ],
                data: request.imageData,
                onComplete: { result in
                    switch result {
                    case .failure(let error, let data):
                        if let errorData = data {
                            if error == .unauthorized {
                                let responseError = try? decoder.decode(SignInErrorResponse.self, from: errorData)
                                promise(.failure(AppError.response(message: responseError?.detail?.message ?? "Unknow server error")))
                            }
                        }
                        break
                    case .success(_):
                        promise(.success(()))
                        break
                    }
                }
            )
        }
    }
}
