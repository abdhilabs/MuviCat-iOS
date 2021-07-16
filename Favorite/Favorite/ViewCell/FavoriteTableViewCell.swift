//
//  FavoriteTableViewCell.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import UIKit
import Core

protocol FavoriteViewControllerDelegate: class {
    func updateFavorite(idMovie: Int)
}

class FavoriteTableViewCell: UITableViewCell {
    weak var delegate: FavoriteViewControllerDelegate?

    @IBOutlet weak var imageBanner: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelGenres: UILabel!
    
    private var idMovie = 0
    
    func setCellWithValuesOf(_ movie: MovieModel) {
        idMovie = movie.id
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)")
        let years = movie.releaseDate.split(separator: "-").first ?? ""
        self.imageBanner.sd_setImage(with: url, placeholderImage: UIImage(named: "arrow.down.to.line.alt"))
        self.labelTitle.text = movie.title
        self.labelYear.text = "\(years)"
        self.labelGenres.text = movie.genres
    }
    
    func delegate(delegate: FavoriteViewControllerDelegate) {
        self.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4, left: 10, bottom: 4, right: 10))
    }
    
    @IBAction func imageFavTapped(_ sender: Any) {
        delegate?.updateFavorite(idMovie: idMovie)
    }
    
}
