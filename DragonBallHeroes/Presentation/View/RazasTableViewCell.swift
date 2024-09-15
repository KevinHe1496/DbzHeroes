//
//  RazasTableViewCell.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 14/9/24.
//

import UIKit
// final para micro optimizaciones
final class RazasTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    // este sera el identier de nuestro cell
    // representando seria esto "RazasTableViewCell" debe ser siempre string
    static let identifier = String(describing: RazasTableViewCell.self)
    
    // MARK: - Outlets
    @IBOutlet weak var razaImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!

    
    //MARK: - Configuration
    // aqui adentro de la funcion configuraremos nuestros Outlets
    func configure(with raza: Razas){
        // nos da el valor de nuestro enum - String
        titleLabel.text = raza.rawValue
        
        guard let imageURL = raza.imageURL else{
            return
        }
        razaImageView.setImage(url: imageURL)
    }
}
