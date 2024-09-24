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
    
    private var token: String?
    
    private let client: APIClientProtocol
    
    private init(client: APIClientProtocol = APIClient()){
        self.client = client
        
    }
    
    // MARK: - Login
    
    func login(
        user: String,
        password: String,
        completion: @escaping (Result<String, DbzError>) -> Void
    ) {
        var componets = baseComponents
        componets.path = "/api/auth/login"
        
        guard let url = componets.url else{
            completion(.failure(.malformedURL))
            return
        }
        // este string se creara con el siguiente formato:
        //(user):(password)
        // kevin_heredia10@hotmail.com:123456
        let loginString = String(format: "%@:%@", user, password)
        guard let loginData = loginString.data(using: .utf8) else{
            completion(.failure(.noData))
            return
        }
        // Encryptamos los datos que acabamos de crear
        // Utilizamos un algoritmo de encriptacion para no pasarle
        // el usuario y la contraseña en texto plano
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        client.authenticate(request){ [weak self] result in
            switch result{
                
            case let .success(token):
                
                self?.token = token
                LocalDataModel.save(value: token)
            case .failure:
                break
            }
            completion(result)
        }
    }
    
    // MARK: - Get Personajes
    
    func getAllCharacters(completion: @escaping (Result<[DbzCharacter], DbzError>) -> Void){
        // Creamos nuestra url request
        var components = baseComponents
        components.path = "/api/heros/all"
        
        guard let url = components.url else{
            completion(.failure(.malformedURL))
            return
        }
        
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["name": ""]) else{
            completion(.failure(.unknown))
            return
        }
        
        guard let token = LocalDataModel.get() else{
            completion(.failure(.unknown))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = serializedBody
        
        client.request(urlRequest, using: [DbzCharacter].self, completion: completion)
        
       
    }
    
    
    // MARK: - Get Tranformaciones
    
    func getTransformations(
        for character: DbzCharacter,
        completion: @escaping (Result<[Transformation], DbzError>) -> Void
    ){
        var components = baseComponents
        components.path = "/api/heros/tranformations"
        
        guard let url = components.url else{
            completion(.failure(.malformedURL))
            return
        }
        
        // aqui le mandamos esto a la api 
        guard let serializedBody = try? JSONSerialization.data(withJSONObject: ["id": character.id]) else{
            completion(.failure(.unknown))
            return
        }
        
        guard let token = LocalDataModel.get() else{
            completion(.failure(.unknown))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = serializedBody
        
        client.request(request, using: [Transformation].self, completion: completion)
        
    }
    
}
