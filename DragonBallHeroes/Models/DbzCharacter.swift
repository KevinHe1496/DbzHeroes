//
//  DbzCharacter.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 13/9/24.
//

import Foundation

struct DbzCharacter: Codable, Hashable {
    
    let photo: String
    let id: String
    let favorite: Bool
    let name: String
    let description: String

}

