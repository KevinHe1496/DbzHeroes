//
//  PersonajesTableViewCell.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 14/9/24.
//

import UIKit

final class PersonajesTableViewCell: UITableViewCell {
    
    // MARK: - Identifier

    static let identifier = String(describing: PersonajesTableViewCell.self)
    
    
    // MARK: - Outlets
    @IBOutlet weak var personajeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!


}
