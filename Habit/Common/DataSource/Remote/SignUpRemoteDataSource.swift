//
//  RemoteDataSource.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 21/02/24.
//

import Foundation
import Combine

class SignUpRemoteDataSource {
    
    static var signUpRemoteDataSourceShared = SignUpRemoteDataSource()
    
    func postUser(
        request: SignUpRequest
    ) -> Future<Bool, AppError> {
        
        let decoder = JSONDecoder()
        
        return Future { promise in
            WebService.callJsonFormat(
                pathEnum: WebService.Endpoint.postUser,
                method: WebService.RequestType.POST,
                body: request,
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
                    case .success(_):
                        promise(.success(true))
                        break
                    }
                }
            )
        }
    }
}
