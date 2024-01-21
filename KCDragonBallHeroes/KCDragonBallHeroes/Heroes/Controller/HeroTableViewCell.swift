//
//  HeroTableViewCell.swift
//  KCDragonBallHeroes
//
//  Created by Robert Aguero on 1/21/24.
//

import UIKit

final class HeroTableViewCell: UITableViewCell {
    // MARK: - Identifier
    static let identifier = "HeroTableViewCell"
    
    // MARK: Outlets
    @IBOutlet weak var heroImageView: UIImageView!
    
    @IBOutlet weak var heroNameLabel: UILabel!
    
    @IBOutlet weak var heroDescriptionLabel: UILabel!
    
    //MARK: - Configure
    
    func configure(with hero: DragonBallHero){
        heroNameLabel.text = hero.name
        heroDescriptionLabel.text = hero.description
        guard let imageURL = URL(string: hero.photo) else {
            return
        }
        heroImageView.setImage(url: imageURL)
        heroImageView.layer.cornerRadius = heroImageView.bounds.size.width / 2.0
    }
}
