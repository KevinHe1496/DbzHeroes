//
//  APIClient.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 18/9/24.
//

import Foundation

// MARK: Errores

// Definimos errores

enum DbzError: Error, Equatable{
    case malformedURL
    case noData
    case decodingFailed
    case statusCode(code: Int?)
    case unknown
}


protocol APIClientProtocol {
    var session: URLSession { get }
    
    func authenticate(_ request: URLRequest, completion: @escaping (Result<String, DbzError>) -> Void)
    
    func request<T: Decodable>(_ request: URLRequest, using: T.Type, completion: @escaping (Result<T, DbzError>) -> Void)
}


struct APIClient: APIClientProtocol {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    
    // MARK: - Authenticate
    
    func authenticate(
        _ request: URLRequest,
        completion: @escaping (Result<String, DbzError>) -> Void) {
            let task = session.dataTask(with: request) { data, response, error in
                let result: Result<String, DbzError>
                
                defer {
                    completion(result)
                }
                guard error == nil else{
                    result = .failure(.unknown)
                    return
                }
                guard let data else{
                    result = .failure(.noData)
                    return
                }
                
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                
                guard statusCode == 200 else{
                    result = .failure(.statusCode(code: statusCode))
                    return
                }
                
                // este es el token
                guard let token = String(data: data, encoding: .utf8) else{
                    result = .failure(.decodingFailed)
                    return
                }
                result = .success(token)
            }
            task.resume()
    }
    
    // MARK: - Request
    
    func request<T: Decodable>(
        _ request: URLRequest,
        using: T.Type,
        completion: @escaping (Result<T, DbzError>) -> Void)  {
            let task = session.dataTask(with: request) { data, response, error in
                let result: Result<T, DbzError>
                
                defer {
                    completion(result)
                }
                
                guard error == nil else{
                    result = .failure(.unknown)
                    return
                }
                guard let data else{
                    result = .failure(.noData)
                    return
                }
                let statusCode = (response as?  HTTPURLResponse)?.statusCode
                guard statusCode == 200 else{
                    result = .failure(.statusCode(code: statusCode))
                    return
                }
                
                guard let model = try? JSONDecoder().decode(using, from: data) else{
                    result = .failure(.decodingFailed)
                    return
                }
                result = .success(model)
            }
            task.resume()
    }
    
}
