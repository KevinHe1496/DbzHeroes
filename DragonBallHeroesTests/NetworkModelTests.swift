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
    private var mockT: APIClientProtocolMock<[Transformation]>!
    // SetUp actua como inicializador para el test unitario
    // Es un buen punto donde resetear el estado del test
    // Tambien inicializamos las propiedades
    override func setUp() {
        super.setUp()
        mock = APIClientProtocolMock()
        sut = NetworkModel(client: mock)
        mockT = APIClientProtocolMock()
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
    
    
    func test_getLogin_success(){
        // Given
        let user = "kevin_heredia10@hotmail.com"
        let password = "123456"
        let someResult = Result<String, DbzError>.success("")
        mock.receivedResultAuthenticate = someResult
        var receivedResult: Result<String, DbzError>?
        // When
        sut.login(user: user, password: password) { result in
            receivedResult = result
        }
        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequestAuthenticate)
    }
    
    func test_getLogin_failure(){
        // Given
        let user = "kevin_heredia10@hotmail.com"
        let password = "123456"
        let someResult = Result<String, DbzError>.failure(.unknown)
        mock.receivedResultAuthenticate = someResult
        var receivedResult: Result<String, DbzError>?
        // When
        sut.login(user: user, password: password) { result in
            receivedResult = result
        }
        
        // Then
        XCTAssertEqual(someResult, receivedResult)
        XCTAssert(mock.didCallRequestAuthenticate)
    }
    
    func test_getTransformations_success(){
        // Given
        let mockTransformations = [Transformation(id: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3", photo: "https://areajugones.sport.es/wp-content/uploads/2020/03/Gorilin.jpg.webp", name: "4. Gorilin", description: "Es la fusión de  Krillin y Kid Goku que apareció por primera vez en Dragon Ball Fusions.")]
        
        let someResult = Result<[Transformation], DbzError>.success(mockTransformations)
        mockT.receivedResult = someResult
        var receivedResult: Result<[Transformation], DbzError>?
        
        var character = DbzCharacter(photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/08/Krilin.jpg?width=300", id: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3", favorite: false, name: "Krilin", description: "Krilin lo tiene todo. Cuando aún no existían los 'memes', Krilin ya los protagonizaba. Junto a Yamcha ha sido objeto de burla por sus desafortunadas batallas en Dragon Ball Z. Inicialmente, Krilin era el mejor amigo de Goku siendo sólo dos niños que querían aprender artes marciales. El Maestro Roshi les entrena para ser dos grandes luchadores, pero la diferencia entre ambos cada vez es más evidente. Krilin era ambicioso y se ablanda con el tiempo. Es un personaje que acepta un papel secundario para apoyar el éxito de su mejor amigo Goku de una forma totalmente altruista.")
        
        // When
        sut = NetworkModel(client: mockT)
        
        sut.getTransformations(for: character) { result in
            receivedResult = result
        }
        
        // Then
        
        XCTAssertEqual(someResult, receivedResult)
        // se va a poner true si hemos llamado el request
        XCTAssert(mockT.didCallRequest)
        
    }
    
    
    
    func test_getTransformations_failure(){
        // Given
        let someResult = Result<[Transformation], DbzError>.failure(.unknown)
        mockT.receivedResult = someResult
        var receivedResult: Result<[Transformation], DbzError>?
        
        var character = DbzCharacter(photo: "https://cdn.alfabetajuega.com/alfabetajuega/2020/08/Krilin.jpg?width=300", id: "D88BE50B-913D-4EA8-AC42-04D3AF1434E3", favorite: false, name: "Krilin", description: "Krilin lo tiene todo. Cuando aún no existían los 'memes', Krilin ya los protagonizaba. Junto a Yamcha ha sido objeto de burla por sus desafortunadas batallas en Dragon Ball Z. Inicialmente, Krilin era el mejor amigo de Goku siendo sólo dos niños que querían aprender artes marciales. El Maestro Roshi les entrena para ser dos grandes luchadores, pero la diferencia entre ambos cada vez es más evidente. Krilin era ambicioso y se ablanda con el tiempo. Es un personaje que acepta un papel secundario para apoyar el éxito de su mejor amigo Goku de una forma totalmente altruista.")
        
        // When
        sut = NetworkModel(client: mockT)
        
        sut.getTransformations(for: character) { result in
            receivedResult = result
        }
        
        // Then
        
        XCTAssertEqual(someResult, receivedResult)
        // se va a poner true si hemos llamado el request
        XCTAssert(mockT.didCallRequest)
        
    }
    

}
