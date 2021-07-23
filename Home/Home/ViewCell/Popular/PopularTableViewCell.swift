//
//  HomeTableViewCell.swift
//  Home
//
//  Created by Abdhi on 23/07/21.
//

import UIKit
import Reusable
import Core

class PopularTableViewCell: UITableViewCell, NibReusable {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var layoutConstraintCollectionViewHeight: NSLayoutConstraint!

  var movieTapHandler: ((Int) -> Void)?
  var movies: [MovieModel]? {
    didSet {
      collectionView.reloadData()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    
    collectionView.register(cellType: PopularItemCollectionViewCell.self)
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    layoutConstraintCollectionViewHeight.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
    setNeedsLayout()
    layoutIfNeeded()
  }
}

extension PopularTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    // Edit Size
//    let width = (collectionView.frame.size.width - 48) / 2
//    let height = 235/164 * width
    return CGSize(width: 102, height: 156)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8.0
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let idMovie = movies?[indexPath.row].id ?? 0
    movieTapHandler?(idMovie)
  }
}

extension PopularTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: PopularItemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.movie = movies?[indexPath.row]
    return cell
  }
}
