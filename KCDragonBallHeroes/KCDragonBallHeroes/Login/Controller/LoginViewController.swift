//
//  LoginViewController.swift
//  KCDragonBallHeroes
//
//  Created by Robert Aguero on 1/20/24.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Model
    private let model = NetworkModel.shared
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Check if exist jwt
        
        if let token = LocalDataModel.getToken() {
                print("TOKEN: \(token)")
                let heroesListViewController = HeroListTableViewController()
                navigationController?.setViewControllers([heroesListViewController], animated: true)
        }
        
         

    }
    
    // MARK: - Actions
    @IBAction func didTapLoginButton(_ sender: Any) {
        
        
        model.login(
            user: emailTextField.text ?? "",
            password: passwordTextField.text ?? "") { [weak self] result in
                //guard let self else { return }
                switch result {
                    case .success(_):
                        DispatchQueue.main.async {
                            let heroesListViewController = HeroListTableViewController()
                            self?.navigationController?.setViewControllers([heroesListViewController], animated: true)
                        }
                    case let .failure(error):
                        print("⛔️ \(error)")
                }
            }
        
    }

}
