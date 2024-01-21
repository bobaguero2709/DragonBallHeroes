//
//  HeroTransformationTableViewCell.swift
//  KCDragonBallHeroes
//
//  Created by Robert Aguero on 1/21/24.
//

import UIKit

final class HeroTransformationTableViewCell: UITableViewCell {

    // MARK: - Identifier
    static let identifier = "HeroTransformationTableViewCell"
    
    // MARK: -Outlets
    @IBOutlet weak var heroTransformationName: UILabel!
    @IBOutlet weak var heroTransformationImage: UIImageView!
    
    @IBOutlet weak var heroTransformationDescription: UILabel!
    
    //MARK: - Configure
    
    func configure(with heroTransformation: HeroTransformation){
        heroTransformationName.text = heroTransformation.name
        heroTransformationDescription.text = heroTransformation.description
        guard let imageURL = URL(string: heroTransformation.photo) else {
            return
        }
        heroTransformationImage.setImage(url: imageURL)
        heroTransformationImage.layer.cornerRadius = heroTransformationImage.bounds.size.width / 2.0
    }
}
