//
//  SliderCollectionViewCell.swift
//  MuviCat
//
//  Created by Abdhi on 19/06/21.
//

import UIKit
import SDWebImage
import Core
import Reusable

class SliderItemCollectionViewCell: UICollectionViewCell, NibReusable {

  @IBOutlet weak var imageBannerMovie: UIImageView!

  var movie: MovieModel? {
    didSet {
      setContent()
    }
  }

  private func setContent() {
    guard let movie = movie else { return }
    let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)")
    self.imageBannerMovie.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholdertext.fill"))
  }
}
