//
//  SceneDelegate.swift
//  KCDragonBallHeroes
//
//  Created by Robert Aguero on 1/20/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, 
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        //Configure first view from source 
        let navigationController = UINavigationController()
        // ORIGINAL
        let loginViewController = LoginViewController()
        navigationController.setViewControllers([loginViewController], animated: true)
        
        
        //PARA VER TABLE VIEW
        //let heroListTableViewController = HeroListTableViewController()
        //navigationController.setViewControllers([heroListTableViewController], animated: true)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
    }

}

