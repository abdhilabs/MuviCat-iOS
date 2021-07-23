//
//  HomeCollectionViewCell.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import UIKit
import Core
import Reusable

class HomeCollectionViewCell: UICollectionViewCell, NibReusable {

  @IBOutlet weak var imagePoster: UIImageView!

  var movie: MovieModel? {
    didSet {
      setContent()
    }
  }

  func setContent() {
    guard let movie = movie else { return }
    let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")
    self.imagePoster.sd_setImage(with: url, placeholderImage: UIImage(named: "arrow.down.to.line.alt"))
  }
}
