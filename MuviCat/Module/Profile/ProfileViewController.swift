//
//  ProfileViewController.swift
//  MuviCat
//
//  Created by Abdhi on 01/07/21.
//

import UIKit
import SDWebImage

class ProfileViewController: UIViewController {
    
    private lazy var profileView: ProfileView = {
        let view = ProfileView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        let atributesTitle = [NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 24, weight: .bold)]
        self.title = "About Me"
        self.navigationController?.navigationBar.titleTextAttributes = atributesTitle
        self.view.backgroundColor = UIColor.bgColor
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.view.addSubview(profileView)
        let imageUrl = URL(string: "https://media-exp3.licdn.com/dms/image/C5103AQEXDfWt-INtIg/profile-displayphoto-shrink_200_200/0/1582125180847?e=1630540800&v=beta&t=TBmcsYcGaAPS2fmqDD-F9-5wSzLr7nvKleQYjqjBz8M")
        self.profileView.imageProfile.sd_setImage(with: imageUrl)
        self.profileView.labelName.text = "MR Abdhi P"
        self.profileView.labelJob.text = "Software Engineer - iOS"
        self.profileView.labelDescription.text = "Hi there! Abdhi's here. I'm focusing on iOS Development. Passionate about developing an awesome app and also have 1+ years experiences about it. "
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            profileView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
