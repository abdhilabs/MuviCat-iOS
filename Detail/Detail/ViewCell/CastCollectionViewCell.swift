//
//  CastCollectionViewCell.swift
//  MuviCat
//
//  Created by Abdhi on 25/06/21.
//

import UIKit
import Core

class CastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageProfile: UIImageView! {
        didSet {
            self.imageProfile.layer.cornerRadius = imageProfile.frame.height / 2
            self.imageProfile.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var labelName: UILabel!
    
    func setCellWithValuesOf(_ cast: CastModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(cast.profilePath)")
        self.imageProfile.sd_setImage(with: url, placeholderImage: UIImage(named: "arrow.down.to.line.alt"))
        self.labelName.text = cast.name
    }
}
