//
//  DetailViewController.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var imagePoster: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDuration: UILabel!
    @IBOutlet weak var labelGenres: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonTrailer: UIButton!
    @IBOutlet weak var buttonAddFavorite: UIButton!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    private let vm: DetailViewModel
    
    private let disposeBag = DisposeBag()
    private var casts = [CastModel]()
    private var isFavourite = false
    var idMovie: Int?
    
    init(viewModel: DetailViewModel) {
        self.vm = viewModel
        super.init(nibName: "DetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.layoutIfNeeded()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.contentView.frame.size.height)
        imagePoster.alpha = 0.5
        buttonTrailer.layer.cornerRadius = 4
        buttonAddFavorite.layer.cornerRadius = 4
        buttonAddFavorite.layer.borderWidth = 0.1
        buttonAddFavorite.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupCollectionView()
        observeMovie()
        observeCast()
        setButtonFavourite()
    }
    
    private func getData() {
        guard let id = idMovie else { return }
        vm.getMovieById(id)
        vm.getCastsByIdMovie(id)
    }
    
    private func setupCollectionView() {
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        
        castCollectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CastCell")
    }
    
    private func observeMovie() {
        vm.movie
            .drive(onNext: {[weak self] data in
                self?.setUI(data)
            })
            .disposed(by: disposeBag)
    }
    
    private func observeCast() {
        vm.cast
            .drive(onNext: {[weak self] data in
                self?.casts = data
                if !data.isEmpty { self?.castCollectionView?.reloadData() }
            })
            .disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setUI(_ item: MovieModel) {
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(item.posterPath)")
        imagePoster.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholdertext.fill"))
        labelTitle.text = item.title
        labelDuration.text = item.runtimeText
        labelGenres.text = item.genres
        labelDescription.text = item.overview
        isFavourite = item.isFavorite
        setButtonFavourite()
    }
    
    @IBAction func backArrowTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func watchTrailerTapped(_ sender: Any) {
        
    }
    
    @IBAction func addToFavTapped(_ sender: Any) {
        guard let id = idMovie else { return }
        if isFavourite {
            vm.updateMovieById(id, false)
        } else {
            vm.updateMovieById(id, true)
        }
        isFavourite = !isFavourite
        setButtonFavourite()
    }
    
    private func setButtonFavourite() {
        if isFavourite {
            buttonAddFavorite.setTitle("Remove Favorite", for: .normal)
            buttonAddFavorite.setImage(UIImage(systemName: "minus"), for: .normal)
            buttonAddFavorite.backgroundColor = .red
        } else {
            buttonAddFavorite.setTitle("Add to Favorite", for: .normal)
            buttonAddFavorite.setImage(UIImage(systemName: "plus"), for: .normal)
            buttonAddFavorite.backgroundColor = .none
        }
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return casts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastCell", for: indexPath) as? CastCollectionViewCell else { fatalError("DequeueReusableCell failed while casting")
        }
        cell.setCellWithValuesOf(casts[indexPath.row])
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCast = castCollectionView.frame.size
        return CGSize(width: 90, height: sizeCast.height)
    }
}
