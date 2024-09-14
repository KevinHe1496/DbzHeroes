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
        let viewController = LoginViewController()
        // Asignamos el primer view controller
        window.rootViewController = viewController
        // Lo hace visible
        window.makeKeyAndVisible()
        self.window = window
    }
}

