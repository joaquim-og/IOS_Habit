//
//  WebService.swift
//  Habit
//
//  Created by joaquim de oliveira gomes on 16/02/24.
//

import Foundation

enum WebService {
    
    enum Endpoint: String {
        case base = "https://habitplus-api.tiagoaguiar.co"
        case postUser = "/users"
        case fetchUser = "/users/me"
        case updateUser = "/users/%d"
        case login = "/auth/login"
        case refreshToken = "/auth/refresh-token"
        case habits = "/users/me/habits"
        case habitsValues = "/users/me/habits/%d/values"
    }
    
    enum RequestType: String {
        case POST = "POST"
        case GET = "GET"
        case PUT = "PUT"
    }
    
    enum ContentType: String {
        case json = "application/json"
        case formUrl = "application/x-www-form-urlencoded"
    }
    
    enum NetworkError {
        case badRequest
        case notFound
        case unauthorized
        case internalServerError
    }
    
    enum Result {
        case success(Data)
        case failure(NetworkError, Data?)
    }
    
    private static func buildEndpointUrl(path: String) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path)") else { return nil }
        return URLRequest(url: url)
    }
    
    static func buildPathString(path: Endpoint, idToUpdate: Int) -> String {
        return String(format: path.rawValue, idToUpdate)
    }
        
    private static func callApi(
        path: String,
        contentType: ContentType,
        method: RequestType,
        data: Data?,
        onComplete: @escaping (Result) -> Void
    ) {
        
        guard var urlRequest = buildEndpointUrl(path: path) else {
            return
        }
        
        _ = LocalDataSource.sharedLocalDataSource.getUserAuth()
            .sink { userAuth in
                if let user = userAuth {
                    urlRequest.setValue("\(user.tokenType) \(user.idToken)", forHTTPHeaderField: "Authorization")
                }
                
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: "accept")
                urlRequest.setValue(contentType.rawValue, forHTTPHeaderField: "Content-Type")
                urlRequest.httpBody = data
                       
                let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                    guard let data = data, error == nil else {
                        onComplete(.failure(.internalServerError, nil))
                        return
                    }
                    
                    if let responseParsed = response as? HTTPURLResponse {
                        switch responseParsed.statusCode {
                        case 400:
                            onComplete(.failure(.badRequest, data))
                            break
                        case 401:
                            onComplete(.failure(.unauthorized, data))
                            break
                        case 200:
                            onComplete(.success(data))
                        default:
                            break
                        }
                    }
                }
                task.resume()
            }
    }
    
    static func callJsonFormat<T: Encodable>(
        pathEnum: Endpoint? = nil,
        pathString: String? = nil,
        method: RequestType,
        body: T,
        onComplete: @escaping (Result) -> Void
    ) {
        guard let jsonData = try? JSONEncoder().encode(body) else {return}
              
        if let pathEnum = pathEnum {
            callApi(path: pathEnum.rawValue, contentType: ContentType.json, method: method, data: jsonData, onComplete: onComplete)
        }
        
        if let pathString = pathString {
            callApi(path: pathString, contentType: ContentType.json, method: method, data: jsonData, onComplete: onComplete)
        }
    }
    
    static func callJsonFormatWithoutBody(
        pathEnum: Endpoint? = nil,
        pathString: String? = nil,
        method: RequestType,
        onComplete: @escaping (Result) -> Void
    ) {
        if let pathEnum = pathEnum {
            callApi(path: pathEnum.rawValue, contentType: ContentType.json, method: method, data: nil, onComplete: onComplete)
        }
        
        if let pathString = pathString {
            callApi(path: pathString, contentType: ContentType.json, method: method, data: nil, onComplete: onComplete)
        }
    }
    
    static func callFormDataFormat(
        path: Endpoint,
        method: RequestType,
        params: [URLQueryItem],
        onComplete: @escaping (Result) -> Void
    ) {
        guard let urlRequest = buildEndpointUrl(path: path.rawValue) else {
            return
        }
        
        guard let absoluteUrl = urlRequest.url?.absoluteString else {
            return
        }
        var components = URLComponents(string: absoluteUrl)
        components?.queryItems = params
               
        callApi(path: path.rawValue, contentType: ContentType.formUrl, method: method, data: components?.query?.data(using: .utf8), onComplete: onComplete)
    }
}
