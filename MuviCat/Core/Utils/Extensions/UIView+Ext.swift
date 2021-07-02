//
//  UIView+Ext.swift
//  MuviCat
//
//  Created by Abdhi on 02/07/21.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
      for view in views {
        addSubview(view)
      }
    }
}
