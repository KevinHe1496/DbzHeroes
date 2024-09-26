import UIKit

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginTextField.delegate = self
        passwordTextField.delegate = self
    }

    // MARK: - Actions
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
    
            return
        }
        
        getToken(user: login, password: password)
    }
    
    // MARK: - Login and Token
    
    func getToken(user: String, password: String) {
        NetworkModel.shared.login(user: user, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(token):
                    let personajesListViewController = PersonajesListViewController()
                    self?.navigationController?.show(personajesListViewController, sender: self)
                case .failure:
                    break
                }
            }
        }
    }
}

// MARK: - UITextfieldDelegate

extension LoginViewController: UITextFieldDelegate{
    
    // oculta el teclado cuando se presiona el boton
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        
    }
    
}
