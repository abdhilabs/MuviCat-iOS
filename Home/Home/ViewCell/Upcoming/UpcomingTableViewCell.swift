//
//  UpcomingTableViewCell.swift
//  Home
//
//  Created by Abdhi on 23/07/21.
//

import UIKit
import Core
import Reusable

class UpcomingTableViewCell: UITableViewCell, NibReusable {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var layoutConstraintCollectionViewHeight: NSLayoutConstraint!

  var movie: [MovieModel]? {
    didSet {
      collectionView.reloadData()
    }
  }

  override func awakeFromNib() {
    super.awakeFromNib()
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    collectionView.register(cellType: UpcomingItemCollectionViewCell.self)
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    layoutConstraintCollectionViewHeight.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
    setNeedsLayout()
    layoutIfNeeded()
  }
}

extension UpcomingTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 102, height: 156)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 8.0
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Handle selectItem
  }
}

extension UpcomingTableViewCell: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return movie?.count ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: UpcomingItemCollectionViewCell = collectionView.dequeueReusableCell(for: indexPath)
    cell.movie = movie?[indexPath.row]
    return cell
  }
}
