//
//  SearchCollectionViewCell.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imagePoster: UIImageView! {
        didSet {
            imagePoster.layer.cornerRadius = 16
            imagePoster.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelActors: UILabel!
    
    func setCellWithValuesOf(_ movie: MovieModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
        self.imagePoster.sd_setImage(with: url, placeholderImage: UIImage(named: "arrow.down.to.line.alt"))
        self.labelTitle.text = movie.title
        self.labelActors.text = movie.genres
    }
}
