//
//  DescriptionViewController.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 17/9/24.
//

import UIKit

class DescriptionViewController: UIViewController {

    
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    configureView()
    }

    @IBAction func TransformationButtonPressed(_ sender: UIButton) {
        
    }
    

}


private extension DescriptionViewController{
    func configureView(){
        titleLabel.text = "Goku"
        
        
    }
}
