//
//  SliderCollectionViewCell.swift
//  MuviCat
//
//  Created by Abdhi on 19/06/21.
//

import UIKit
import SDWebImage

class SliderCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageBannerMovie: UIImageView!
    
    func setCellWithValuesOf(_ movie: MovieModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)")
        self.imageBannerMovie.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholdertext.fill"))
    }
}
