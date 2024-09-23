//
//  TranformationTableViewCell.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 19/9/24.
//

import UIKit

class TransformationTableViewCell: UITableViewCell {
    
    // MARK: - Identifier
    static let identifier = String(describing: TransformationTableViewCell.self)
    
    // MARK: - Outlets
    @IBOutlet weak var TransformacionImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    
}
