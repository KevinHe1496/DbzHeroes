//
//  SceneDelegate.swift
//  DragonBallHeroes
//
//  Created by Kevin Heredia on 13/9/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        // Desempaquetamos la scene
        guard let scene = (scene as? UIWindowScene) else { return }
        // Creamos una nueva ventana
        let window = UIWindow(windowScene: scene)
        // Instanciamos el primer ViewController()
        let loginViewController = LoginViewController()
        
        let navigationController = UINavigationController(rootViewController: loginViewController)
  
        
        // Asignamos el primer view controller
        // este será la primera pantalla que se muestre en la aplicación
        window.rootViewController = navigationController
        // Lo hace visible
        window.makeKeyAndVisible()
        self.window = window
    }
}




