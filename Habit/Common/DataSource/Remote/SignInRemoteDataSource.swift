//
//  RemoteDataSource.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 21/02/24.
//

import Foundation
import Combine

class SignInRemoteDataSource {
    
    static var signInRemoteDataSourceShared = SignInRemoteDataSource()
    
    func login(request: SignInRequest) -> Future<SignInResponse, AppError> {
        let decoder = JSONDecoder()
        
        return Future<SignInResponse, AppError> { promise in
            WebService.callFormDataFormat(
                path: WebService.Endpoint.login,
                method: WebService.RequestType.POST,
                params: [
                    URLQueryItem(name: "username", value: request.email),
                    URLQueryItem(name: "password", value: request.password)
                ],
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
                    case .success(let data):
                        let responseDecoded = try? decoder.decode(SignInResponse.self, from: data)
                        
                        if let response = responseDecoded {
                            promise(.success(response))
                        }
                        break
                    }
                }
            )
        }
    }
}
