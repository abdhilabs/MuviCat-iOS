//
//  HomeViewController.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    @IBOutlet weak var popularCollectionView: UICollectionView!
    @IBOutlet weak var upcomingCollectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loadingSlider: UIActivityIndicatorView!
    @IBOutlet weak var loadingPopular: UIActivityIndicatorView!
    @IBOutlet weak var loadingUpcoming: UIActivityIndicatorView!
    
    private lazy var logoIcon: [UIBarButtonItem] = {
        let logoImage = UIImage.init(named: "logoMuvi")
        let logoImageView = UIImageView.init(image: logoImage)
        logoImageView.contentMode = .scaleAspectFit
        let imageItem = UIBarButtonItem.init(customView: logoImageView)
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = -25
        return [negativeSpacer, imageItem]
    }()
    
    private lazy var notificationIcon: UIBarButtonItem = {
        let btn = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: nil)
        btn.tintColor = .white
        return btn
    }()
    
    private let useCase = Injection.init().provideHome()
    private var vm: HomeViewModel?
    private var movies = [MovieModel]()
    private var popularMovies = [MovieModel]()
    private var upcomingMovies = [MovieModel]()
    private let disposeBag = DisposeBag()
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.bgColor
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        
        navigationItem.leftBarButtonItems = logoIcon
        navigationItem.rightBarButtonItem = notificationIcon
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
    }
    
    private func observeMovies() {
        vm?.moviesPopular
            .drive(onNext: {[weak self] (data) in
                switch data {
                    case .loading:
                        self?.loadingSlider.startAnimating()
                        self?.loadingPopular.startAnimating()
                    case .success(let result):
                        self?.hideProgressViewPopular()
                        self?.movies = result
                        self?.popularMovies = result
                        self?.sliderCollectionView.reloadData()
                        self?.popularCollectionView.reloadData()
                    case .failure(let msg):
                        print("Error: \(msg)")
                    default:
                        print("Nothing happend")
                }
            })
            .disposed(by: disposeBag)
        
        vm?.moviesUpcoming
            .drive(onNext: {[weak self] data in
                switch data {
                    case .loading:
                        self?.loadingUpcoming.startAnimating()
                    case .success(let result):
                        self?.upcomingMovies = result
                        self?.upcomingCollectionView.reloadData()
                        self?.hideProgressViewUpcoming()
                    case .failure(let msg):
                        self?.hideProgressViewUpcoming()
                        print("Error: \(msg)")
                    default:
                        print("Nothing happend")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func hideProgressViewPopular() {
        self.loadingSlider.stopAnimating()
        self.loadingSlider.hidesWhenStopped = true
        self.loadingPopular.stopAnimating()
        self.loadingPopular.hidesWhenStopped = true
    }
    
    private func hideProgressViewUpcoming() {
        self.loadingUpcoming.stopAnimating()
        self.loadingUpcoming.hidesWhenStopped = true
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.layoutIfNeeded()
        scrollView.isScrollEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(width: self.scrollView.contentSize.width, height: self.contentView.frame.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        vm = HomeViewModel(homeUseCase: useCase)
        setupUI()
        setupCollectionView()
        observeMovies()
    }
    
    private func setupCollectionView() {
        sliderCollectionView.dataSource = self
        sliderCollectionView.delegate = self
        
        popularCollectionView.dataSource = self
        popularCollectionView.delegate = self
        
        upcomingCollectionView.dataSource = self
        upcomingCollectionView.delegate = self
        
        sliderCollectionView.register(UINib(nibName: "SliderCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SliderCell")
        popularCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
        upcomingCollectionView.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeCell")
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sliderCollectionView {
            return movies.count
        } else if collectionView == popularCollectionView {
            return popularMovies.count
        } else {
            return upcomingMovies.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == sliderCollectionView {
            guard let sliderCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCell", for: indexPath) as? SliderCollectionViewCell else { fatalError("DequeueReusableCell failed while casting")
            }
            let movie = movies[indexPath.row]
            sliderCell.setCellWithValuesOf(movie)
            return sliderCell
        } else if collectionView == popularCollectionView {
            guard let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCollectionViewCell else { fatalError("DequeueReusableCell failed while casting")
            }
            let movie = popularMovies[indexPath.row]
            homeCell.setCellWithValuesOf(movie)
            return homeCell
        } else if collectionView == upcomingCollectionView {
            guard let homeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath) as? HomeCollectionViewCell else { fatalError("DequeueReusableCell failed while casting")
            }
            let movie = upcomingMovies[indexPath.row]
            homeCell.setCellWithValuesOf(movie)
            return homeCell
        }
        return UICollectionViewCell()
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeSlider = sliderCollectionView.frame.size
        let sizePopular = popularCollectionView.frame.size
        let sizeUpcoming = upcomingCollectionView.frame.size
        if collectionView == sliderCollectionView {
            return CGSize(width: sizeSlider.width, height: sizeSlider.height)
        } else if collectionView == popularCollectionView {
            return CGSize(width: 104, height: sizePopular.height)
        } else {
            return CGSize(width: 104, height: sizeUpcoming.height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == sliderCollectionView {
            return 0.0
        } else if collectionView == popularCollectionView {
            return 8.0
        } else {
            return 8.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = DetailViewController(nibName: "DetailViewController", bundle: nil)
        if collectionView == sliderCollectionView {
            let idMovie = movies[indexPath.row].id
            detail.idMovie = idMovie
            self.navigationController?.pushViewController(detail, animated: true)
        } else if collectionView == popularCollectionView {
            let idMovie = popularMovies[indexPath.row].id
            detail.idMovie = idMovie
            self.navigationController?.pushViewController(detail, animated: true)
        }
    }
}
