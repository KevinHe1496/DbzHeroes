//
//  DragonBallHeroesTests.swift
//  DragonBallHeroesTests
//
//  Created by Kevin Heredia on 24/9/24.
//

import XCTest
@testable import DragonBallHeroes

final class NetworkModelTests: XCTestCase {
    
    private var sut: NetworkModel!
    private var mock: APIClientProtocolMock<[DbzCharacter]>!
    // SetUp actua como inicializador para el test unitario
    // Es un buen punto donde resetear el estado del test
    // Tambien inicializamos las propiedades
    override func setUp() {
        super.setUp()
        mock = APIClientProtocolMock()
        sut = NetworkModel(client: mock)
    }
    // estamos verificando el comportamiento del network model
    // cuando el APIClientProtocol devuelve un sucess
    func test_getAllCharacters_sucess(){
        // Given
        let someResult = Result<[DbzCharacter], DbzError>.success([])
        mock.receivedResult = someResult
        var receivedResult: Result<[DbzCharacter], DbzError>?
        
  
        // When
        sut.getAllCharacters { result in
            receivedResult = result
        }
        
        // Then
        
        XCTAssertEqual(someResult, receivedResult)
        // se va a poner true si hemos llamado el request
        XCTAssert(mock.didCallRequest)
        
    }
    
    
    func test_getAllCharacters_failure(){
        // Given
        let someResult = Result<[DbzCharacter], DbzError>.failure(.unknown)
        mock.receivedResult = someResult
        var receicedResult: Result<[DbzCharacter], DbzError>?
        // When
        sut.getAllCharacters { result in
            receicedResult = result
        }
        
        // Then
        XCTAssertEqual(someResult, receicedResult)
        XCTAssert(mock.didCallRequest)
    }
}
