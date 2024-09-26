//
//  TransfomationDetailViewController.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 24/9/24.
//

import UIKit

final class TransfomationDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionImageView: UIImageView!
    
    @IBOutlet weak var bodyLabel: UILabel!
    
    // MARK: - Model
    private let transformation: Transformation
    
    // MARK: - Initializers
    init(transformation: Transformation) {
        
        self.transformation = transformation
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurationView(for: transformation)

    }




}

// MARK: - Configuration View

private extension TransfomationDetailViewController{
    func configurationView(for transformation: Transformation){
        titleLabel.text = transformation.name
        bodyLabel.text = transformation.description
        
        guard let url = URL(string: transformation.photo) else{
            return
        }
        
        descriptionImageView.setImage(url: url)
    }
}
