//
//  SplashRemoteDataSource.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 23/02/24.
//

import Foundation
import Combine

class SplashRemoteDataSource {
    
    static var splashRemoteDataSourceShared = SplashRemoteDataSource()
    
    func refreshToken(request: RefreshRequest) -> Future<SignInResponse, AppError> {
        let decoder = JSONDecoder()
        
        return Future<SignInResponse, AppError> { promise in
            WebService.callJsonFormat(
                path: WebService.Endpoint.refreshToken,
                method: WebService.RequestType.PUT,
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
                    case .success(let data):
                        let response = try? decoder.decode(SignInResponse.self, from: data)
                        
                        if let responseUnwrapped = response {
                            promise(.success(responseUnwrapped))
                        }
                        break
                    }
                }
            )
        }
    }
}
