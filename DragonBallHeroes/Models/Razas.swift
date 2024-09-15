//
//  Razas.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 13/9/24.
//

import Foundation

enum Razas: String, CaseIterable{
    case sayayin = "Sayayin"
    case humanos = "Humanos"
    case namekusein = "Namekusein"
}


extension Razas {
    var imageURL: URL? {
        switch self {
        case .sayayin:
            URL(string: "https://awoiaf.westeros.org/images/1/19/House_Stark.png")
        case .humanos:
            URL(string: "https://awoiaf.westeros.org/images/thumb/1/1e/House_Targaryen.svg/545px-House_Targaryen.svg.png")
        case .namekusein:
            URL(string: "https://awoiaf.westeros.org/images/8/88/House_Lannister.png")
        }
    }
}
