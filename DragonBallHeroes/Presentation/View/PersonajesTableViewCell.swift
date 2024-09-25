//
//  PersonajesTableViewCell.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 14/9/24.
//

import UIKit
// final para micro optimizaciones
final class PersonajesTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    // este sera el identier de nuestro cell
    // representando seria esto "RazasTableViewCell" debe ser siempre string
    static let identifier = String(describing: PersonajesTableViewCell.self)
    
    
    // MARK: - Outlets
    @IBOutlet weak var personajeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!


}
