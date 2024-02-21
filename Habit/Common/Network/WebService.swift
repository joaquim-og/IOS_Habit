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
        case login = "/auth/login"
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
    
    private static func buildEndpointUrl(path: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(Endpoint.base.rawValue)\(path.rawValue)") else { return nil }
        return URLRequest(url: url)
    }
        
    private static func callApi(
        path: Endpoint,
        contentType: ContentType,
        method: RequestType,
        data: Data?,
        onComplete: @escaping (Result) -> Void
    ) {
        
        guard var urlRequest = buildEndpointUrl(path: path) else {
            return
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
    
    private static func callJsonFormat<T: Encodable>(
        path: Endpoint,
        method: RequestType,
        body: T,
        onComplete: @escaping (Result) -> Void
    ) {
        guard let jsonData = try? JSONEncoder().encode(body) else {return}
               
        callApi(path: path, contentType: ContentType.json, method: method, data: jsonData, onComplete: onComplete)
    }
    
    private static func callFormDataFormat(
        path: Endpoint,
        method: RequestType,
        params: [URLQueryItem],
        onComplete: @escaping (Result) -> Void
    ) {
        guard let urlRequest = buildEndpointUrl(path: path) else {
            return
        }
        
        guard let absoluteUrl = urlRequest.url?.absoluteString else {
            return
        }
        var components = URLComponents(string: absoluteUrl)
        components?.queryItems = params
               
        callApi(path: path, contentType: ContentType.formUrl, method: method, data: components?.query?.data(using: .utf8), onComplete: onComplete)
    }
    
    static func postUser(
        request: SignUpRequest,
        onComplete: @escaping (Bool?, ErrorReponse?) -> Void
    ) {
        
        let decoder = JSONDecoder()
                
        callJsonFormat(
            path: Endpoint.postUser,
            method: RequestType.POST,
            body: request,
            onComplete: { result in
                switch result {
                case .failure(let error, let data):
                    if let errorData = data {
                        if error == .badRequest {
                            let responseError = try? decoder.decode(ErrorReponse.self, from: errorData)
                            onComplete(nil, responseError)
                        }
                    }
                    break
                case .success(let data):
                    let response = try? decoder.decode(SignUpResponse.self, from: data)
                    onComplete(true, nil)
                    break
                }
            }
        )
    }
    
    static func login(
        request: SignInRequest,
        onComplete: @escaping (SignInResponse?, SignInErrorResponse?) -> Void
    ) {
        
        let decoder = JSONDecoder()
                
        callFormDataFormat(
            path: Endpoint.login,
            method: RequestType.POST,
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
                            onComplete(nil, responseError)
                        }
                    }
                    break
                case .success(let data):
                    let response = try? decoder.decode(SignInResponse.self, from: data)
                    onComplete(response, nil)
                    break
                }
            }
        )
    }
}
