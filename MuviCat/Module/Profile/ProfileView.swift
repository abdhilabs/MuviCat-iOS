//
//  ProfileView.swift
//  MuviCat
//
//  Created by Abdhi on 01/07/21.
//

import UIKit

class ProfileView: UIView {
    
    lazy var imageProfile: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelJob: UILabel = {
        let label = UILabel()
        label.font = UIFont.italicSystemFont(ofSize: 14)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var labelDescription: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviews(imageProfile, labelName, labelJob, labelDescription)
    }
    
    private func setupConstraints() {
        // Constraint Image Profile
        NSLayoutConstraint.activate([
            imageProfile.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            imageProfile.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
            imageProfile.heightAnchor.constraint(equalToConstant: 128),
            imageProfile.widthAnchor.constraint(equalToConstant: 128)
        ])
        
        // Constraint Label Name
        NSLayoutConstraint.activate([
            labelName.topAnchor.constraint(equalTo: self.imageProfile.topAnchor),
            labelName.leadingAnchor.constraint(equalTo: self.imageProfile.trailingAnchor, constant: 8),
            labelName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8)
        ])
        
        // Constraint Label Job
        NSLayoutConstraint.activate([
            labelJob.topAnchor.constraint(equalTo: self.labelName.bottomAnchor, constant: 2),
            labelJob.leadingAnchor.constraint(equalTo: self.imageProfile.trailingAnchor, constant: 8),
            labelJob.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8)
        ])
        
        // Constraint Label Description
        NSLayoutConstraint.activate([
            labelDescription.topAnchor.constraint(equalTo: self.labelJob.bottomAnchor, constant: 2),
            labelDescription.leadingAnchor.constraint(equalTo: self.imageProfile.trailingAnchor, constant: 8),
            labelDescription.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8)
        ])
    }
}

