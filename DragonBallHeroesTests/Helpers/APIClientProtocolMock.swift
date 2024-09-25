//
//  APIClientProtocolMock.swift
//  DragonBallHeroesTests
//
//  Created by Kevin Heredia on 24/9/24.
//

import Foundation
@testable import DragonBallHeroes

final class APIClientProtocolMock<C: Decodable>: APIClientProtocol{
    var session: URLSession = .shared
    // saber si estoy llamando al request
    var didCallRequest = false
    // saber si llego el request
    var receivedRequest: URLRequest?
    
    var receivedResult: Result<C, DbzError>?
    
    
    
    func request<T: Decodable>(
        _ request: URLRequest,
        using: T.Type,
        completion: @escaping (Result<T, DragonBallHeroes.DbzError>) -> Void
    ) {
        // saber si llego el request
        receivedRequest = request
        // saber si estoy llamando al request
        didCallRequest = true
        
        if let result = receivedResult as? Result<T, DbzError> {
            completion(result)
        }
    }
    
    // saber si estoy llamando al request
    var didCallRequestAuthenticate = false
    // saber si llego el request
    var receivedRequestAuthenticate: URLRequest?
    
    var receivedResultAuthenticate: Result<String, DbzError>?
    
    func authenticate(_ request: URLRequest, completion: @escaping (Result<String, DragonBallHeroes.DbzError>) -> Void) {
        
        // si le llego el request
        receivedRequestAuthenticate = request
        // sabes si estoy llamando al request
        didCallRequestAuthenticate = true
        // si llego el resultado que quiero
        if let result = receivedResultAuthenticate{
            completion(result)
        }
    }
    
    
}
