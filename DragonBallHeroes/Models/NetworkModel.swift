//
//  NetworkModel.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 18/9/24.
//

import Foundation

final class NetworkModel{
    
    static let shared = NetworkModel()
    
    // aqui obtenemos el url del api - https://dragonball.keepcoding.education
    private var baseComponents: URLComponents{
        var componets = URLComponents()
        componets.scheme = "https"
        componets.host = "dragonball.keepcoding.education"
        return componets
    }
    
    private let client: APIClientProtocol
    
    private init(client: APIClientProtocol = APIClient()){
        self.client = client
        
    }
    
    func getAllCharacters(completion: @escaping (Result<[DbzCharacter], DbzError>) -> Void){
        // Creamos nuestra url request
        var components = baseComponents
        components.path = "/api/heros/all"
        
        guard let url = components.url else{
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        client.requestCharacters(urlRequest, completion: completion)
    }
    
}
