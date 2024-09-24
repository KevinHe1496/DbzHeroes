import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let login = loginTextField.text, !login.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            // Mostrar mensaje de error si los campos están vacíos
            print("Usuario o contraseña vacíos")
            return
        }

        getToken(user: login, password: password)
    }

    func getToken(user: String, password: String) {
        NetworkModel.shared.login(user: user, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(token):
                    print("Token obtenido: \(token)")
                    // Aquí navegas a la siguiente pantalla después de obtener el token
                    let personajesListViewController = PersonajesListViewController()
                    self?.navigationController?.show(personajesListViewController, sender: self)
                case .failure:
                   break
                }
            }
        }
    }
}
