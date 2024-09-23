//
//  LoginViewController.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 13/9/24.
//

import UIKit

class LoginViewController: UIViewController {

    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        
        
        let login = loginTextField.text!
        let password = passwordTextField.text!
        
        
        if login == "kevin_heredia10@hotmail.com" && password == "123456"{
            let personajesListViewController = PersonajesListViewController()
            navigationController?.show(personajesListViewController, sender: self)
        }else{
            print("no existe")
        }
        
        
        

    }
    
}
