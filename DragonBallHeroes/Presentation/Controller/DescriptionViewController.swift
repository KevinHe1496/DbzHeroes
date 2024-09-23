import UIKit

class DescriptionViewController: UIViewController {
    
    // MARK: - Properties
    private let character: DbzCharacter
    
    // MARK: - Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Initializer
    init(character: DbzCharacter) {
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Descripción"
        
        // Configuramos la vista con el character
        configureView(with: character)
    }
    
    // MARK: - Actions
    @IBAction func transformationButtonPressed(_ sender: UIButton) {
        let transformationsViewController = TransformationsListViewController()
        navigationController?.show(transformationsViewController, sender: self)
    
    }

       
}

private extension DescriptionViewController {
    
    // la vista se configura con DbzCharacter
    func configureView(with character: DbzCharacter) {
        titleLabel.text = character.name
        descriptionLabel.text = character.description
        
        
    }
}
