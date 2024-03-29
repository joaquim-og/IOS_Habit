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
    
    func fetchUser() -> Future<ProfileResponse, AppError> {
        
        let decoder = JSONDecoder()
        
        return Future { promise in
            WebService.callJsonFormatWithoutBody(
                pathEnum: WebService.Endpoint.fetchUser,
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
                        let response = try? decoder.decode(ProfileResponse.self, from: data)
                        
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
    
    func updateUser(userId: Int, request: ProfileRequest) -> Future<ProfileResponse, AppError>{
        
        let decoder = JSONDecoder()
        let pathFormatted = WebService.buildPathString(path: WebService.Endpoint.updateUser, idToUpdate: userId)

        return Future { promise in
            WebService.callJsonFormat(
                pathString: pathFormatted,
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
                        let response = try? decoder.decode(ProfileResponse.self, from: data)
                        
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
