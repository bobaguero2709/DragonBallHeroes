//
//  HeroTransformationViewController.swift
//  KCDragonBallHeroes
//
//  Created by Robert Aguero on 1/21/24.
//

import UIKit

final class HeroTransformationDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var heroTransformationNameLabel: UILabel!
    @IBOutlet weak var heroTransformationDescriptionLabel: UILabel!
    @IBOutlet weak var heroTransformationImageView: UIImageView!
    
    private let heroTransformation: HeroTransformation
    
    // MARK: - Initializers
    init(heroTransformation : HeroTransformation){
        self.heroTransformation = heroTransformation
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*,unavailable)
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        // Do any additional setup after loading the view.
    }

}

// MARK: View configuration
private extension HeroTransformationDetailViewController {
    func configureView(){
        heroTransformationNameLabel.text = heroTransformation.name
        heroTransformationDescriptionLabel.text = heroTransformation.description
        guard let imageURL = URL(string: heroTransformation.photo) else {
            return
        }
        heroTransformationImageView.setImage(url: imageURL)
        heroTransformationImageView.layer.cornerRadius = heroTransformationImageView.bounds.size.width / 2.0
    }
}
