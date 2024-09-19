//
//  APIClient.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 18/9/24.
//

import Foundation

// MARK: Errores

// Definimos errores

enum DbzError: Error{
    case noData
    case decodingFailed
    case statusCode(code: Int?)
    case unknown
}


protocol APIClientProtocol {
    var session: URLSession { get }
    
    func requestCharacters(
        _ request: URLRequest,
        completion: @escaping (Result<[DbzCharacter], DbzError>) -> Void)
}


struct APIClient: APIClientProtocol {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Solicitar Personajes
    
    func requestCharacters(
        _ request: URLRequest,
        completion: @escaping (Result<[DbzCharacter], DbzError>) -> Void) {
            
            let task = session.dataTask(with: request) { data, response, error in
                let result: Result<[DbzCharacter], DbzError>
                // este bloque se ejecuta al final de la linea del contexto
                defer {
                    completion(result)
                }
                // Compruebo si obtengo un error
                guard error == nil else{
                    result = .failure(.unknown)
                    return
                }
                // compruebo si obtengo un objeto data
                guard let data else{
                    result = .failure(.noData)
                    return
                }
                
                // obtengo los codigos de estado que devolvera el servidor como 400, 200, 201, 404, 401
                let statusCode = (response as? HTTPURLResponse)?.statusCode
                
                // Compruebo si el codigo de estado es 200
                // Tendriamos que ver la documentacion de la API que estamos usando
                // Para comprobar los codigos de estado
                guard statusCode == 200 else{
                    result = .failure(.statusCode(code: statusCode))
                    return
                }
                
                
                // Intentar decodificar un array de GOTCharacter a traves del objeto data
                // Este objeto data generalmente es el Body de la respuesta del servidor
                guard let characters = try? JSONDecoder().decode([DbzCharacter].self, from: data) else{
                    result = .failure(.decodingFailed)
                    return
                }
                
                result = .success(characters)
                
            }
            
            task.resume()
    }
    
}
