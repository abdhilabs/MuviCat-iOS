//
//  SearchViewController.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import UIKit
import RxSwift
import Core
import Detail

public class SearchViewController: UIViewController {
    
    private lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
    
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var labelResult: UILabel!
    @IBOutlet weak var labelError: UILabel! {
        didSet {
            labelError.text = "We can't find your movies popular here :("
        }
    }
    
    private let vm: SearchViewModel
    
    private let router = DetailRouter()
    private var searchMovies = [MovieModel]()
    private let disposeBag = DisposeBag()
    
    public init(viewModel: SearchViewModel) {
        self.vm = viewModel
        super.init(nibName: "SearchViewController", bundle: Bundle(for: SearchViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
        setupUI()
        setupCollectionView()
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.bgColor
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }
    
    private func setupCollectionView() {
        searchCollectionView.register(UINib(nibName: "SearchCollectionViewCell", bundle: Bundle(for: SearchCollectionViewCell.self)), forCellWithReuseIdentifier: "SearchCell")
        searchCollectionView.delegate = self
        searchCollectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 4
        searchCollectionView.setCollectionViewLayout(layout, animated: true)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        observeMoviesSearch()
    }
    
    private func observeMoviesSearch() {
        vm.moviesSearch
            .drive(onNext: {[weak self] data in
                self?.searchMovies = data
                if !(self?.searchMovies.isEmpty ?? false) {
                    self?.searchCollectionView.isHidden = false
                    self?.searchCollectionView.reloadData()
                    self?.labelError.isHidden = true
                } else {
                    self?.searchCollectionView.isHidden = true
                    self?.labelError.isHidden = false
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.textColor = .white
        searchBar.placeholder = "Find popular movies..."
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
}

extension SearchViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.labelResult.text = "Showing result of '\(searchText)'"
        vm.searchMoviesPopular(query: searchText)
    }
}

extension SearchViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchMovies.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath) as? SearchCollectionViewCell else { fatalError("DequeueReusableCell failed while casting")
        }
        cell.setCellWithValuesOf(searchMovies[indexPath.row])
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 0, bottom: 1.0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let lay = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - lay.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 8, height: 250)
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let idMovie = searchMovies[indexPath.row].id
        let destination = router.navigateDetailView(idMovie)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}
