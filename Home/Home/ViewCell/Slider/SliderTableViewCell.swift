//
//  SliderTableViewCell.swift
//  Home
//
//  Created by Abdhi on 23/07/21.
//

import UIKit
import Reusable
import Core

class SliderTableViewCell: UITableViewCell, NibReusable {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var layoutConstraintCollectionViewHeight: NSLayoutConstraint!

  var movieTapHandler: ((Int) -> Void)?
  var movies: [MovieModel]? {
    didSet {
      collectionView.reloadData()
    }
  }

  var safeLayoutArea: CGRect?

  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.delegate = self
    collectionView.dataSource = self

    collectionView.register(cellType: SliderItemCollectionViewCell.self)
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    layoutConstraintCollectionViewHeight.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
    setNeedsLayout()
    layoutIfNeeded()
  }
}

extension SliderTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = safeLayoutArea?.width ?? 0
    let size = collectionView.frame.size
    return CGSize(width: width, height: size.height)
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let idMovie = movies?[indexPath.row].id ?? 0
    movieTapHandler?(idMovie)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
}

extension SliderTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movies?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: SliderItemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.movie = movies?[indexPath.row]

    return cell
  }
}
