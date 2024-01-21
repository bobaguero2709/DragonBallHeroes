//
//  HeroDetailViewController.swift
//  KCDragonBallHeroes
//
//  Created by Robert Aguero on 1/21/24.
//

import UIKit

final class HeroDetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var heroImageView: UIImageView!
    
    @IBOutlet weak var heroNameLabel: UILabel!
    
    @IBOutlet weak var heroDescriptionLabel: UILabel!
    
    @IBAction func didTapHeroTransformation(_ sender: Any) {
        let heroTransformationTableViewController = HeroTransformationTableViewController(transformations: transformations)
        navigationController?.show(heroTransformationTableViewController,sender: nil)
    }
    @IBOutlet weak var transformationButton: UIButton!
    // MARK: - Model
    private let hero: DragonBallHero
    
    private let model: NetworkModel = .shared
    
    private var transformations: [HeroTransformation] = []
    
    // MARK: - Initializers
    init(hero: DragonBallHero){
        self.hero = hero
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        model.getTransformations(id: self.hero.id) { [weak self] result in
            switch result {
            case let .success(transformations):
                self?.transformations = transformations
            case let .failure(error):
                print(error)
            }
        }
        
        configureView()
         
    }
    


}

// MARK: View configuration
private extension HeroDetailViewController {
    func configureView(){
        heroNameLabel.text = hero.name
        heroDescriptionLabel.text = hero.description
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        heroImageView.setImage(url: imageURL)
        heroImageView.layer.cornerRadius = heroImageView.bounds.size.width / 2.0
        // show button
    
        /*
        print("TRANSFORMACIONES \(transformations)")
        if(transformations.isEmpty){
            transformationButton.isHidden = true
        }else{
            transformationButton.isHidden = false
        }*/
         
    }
}
