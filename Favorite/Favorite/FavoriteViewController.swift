//
//  FavoriteViewController.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import UIKit
import RxSwift
import Core
import Detail

public class FavoriteViewController: UIViewController, FavoriteViewControllerDelegate {
    
    private lazy var searchBar: UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 20))
    
    @IBOutlet weak var favoritetableView: UITableView!
    
    private let vm: FavoriteViewModel
    
    private let router = DetailRouter()
    private let disposeBag = DisposeBag()
    private var favoriteMovies = [MovieModel]()
    
    public init(viewModel: FavoriteViewModel) {
        self.vm = viewModel
        super.init(nibName: "FavoriteViewController", bundle: Bundle(for: FavoriteViewController.self))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
        setupUI()
        vm.getFavoriteMovies()
    }
    
    private func setupUI() {
        self.view.backgroundColor = UIColor.bgColor
        self.navigationController?.navigationBar.barTintColor = UIColor.black
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        observeMoviesFavorite()
        observeUpdateFavorite()
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.searchTextField.textColor = .white
        searchBar.placeholder = "Find your favorite movies..."
        let leftNavBarButton = UIBarButtonItem(customView: searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    private func setupTableView() {
        favoritetableView.dataSource = self
        favoritetableView.delegate = self
        favoritetableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: Bundle(for: FavoriteTableViewCell.self)), forCellReuseIdentifier: "FavoriteCell")
    }
    
    func observeMoviesFavorite() {
        vm.moviesFavorite
            .drive(onNext: {[weak self] data in
                self?.favoriteMovies = data
                if !(self?.favoriteMovies.isEmpty ?? true) {
                    self?.favoritetableView.reloadData()
                } else {
                    self?.favoritetableView.reloadData()
                    self?.messageEmpty("You don't have movie favorite")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func observeUpdateFavorite() {
        vm.updateFavorite
            .drive(onNext: {[weak self] state in
                if state {
                    self?.vm.getFavoriteMovies()
                }
            })
            .disposed(by: disposeBag)
    }
}

extension FavoriteViewController: UISearchBarDelegate {
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty { vm.getFavoriteMovies() }
        else { vm.searchFavoriteMovies(query: searchText) }
    }
}

extension FavoriteViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as? FavoriteTableViewCell else {
            fatalError("DequeueReusableCell failed while casting")
        }
        let movie = favoriteMovies[indexPath.row]
        cell.setCellWithValuesOf(movie)
        cell.delegate(delegate: self)
        return cell
    }
}

extension FavoriteViewController {
    func updateFavorite(idMovie: Int) {
        vm.updateMovieById(idMovie, false)
    }
}

extension FavoriteViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let idMovie = favoriteMovies[indexPath.row].id
        let destination = router.navigateDetailView(idMovie)
        self.navigationController?.pushViewController(destination, animated: true)
    }
}
