//
//  UIViewController+Ext.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import UIKit

extension UIViewController {
    
    func messageEmpty(_ message: String) {
        let alert = UIAlertController(title: "Info", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
