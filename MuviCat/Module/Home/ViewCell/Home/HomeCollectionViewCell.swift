//
//  HomeCollectionViewCell.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagePoster: UIImageView!

    func setCellWithValuesOf(_ movie: MovieModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
        self.imagePoster.sd_setImage(with: url, placeholderImage: UIImage(named: "arrow.down.to.line.alt"))
    }
}
