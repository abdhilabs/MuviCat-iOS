//
//  HomeViewController.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import UIKit
import RxSwift
import Core
import Detail
import Fortils

public class HomeViewController: UIViewController {

  @IBOutlet weak var homeTableView: UITableView!

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

  private let router = DetailRouter()
  private var movies = [MovieModel]()
  private var popularMovies = [MovieModel]()
  private var upcomingMovies = [MovieModel]()
  private let disposeBag = DisposeBag()

  let vm: HomeViewModel

  public init(viewModel: HomeViewModel) {
    self.vm = viewModel
    super.init(nibName: "HomeViewController", bundle: Bundle(for: HomeViewController.self))
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  enum HomeSection {
    case slider
    case popular
    case upcoming
  }

  var sections: [HomeSection] = [.slider, .popular, .upcoming]

  public override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
    setupViews()
    observeMovies()
  }

  private func setupUI() {
    self.view.backgroundColor = UIColor.bgColor
    self.navigationController?.navigationBar.barTintColor = UIColor.black

    navigationItem.leftBarButtonItems = logoIcon
    navigationItem.rightBarButtonItem = notificationIcon
  }

  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = false
    navigationController?.navigationBar.isHidden = false
  }

  private func observeMovies() {
    vm.moviesPopular
      .drive(onNext: {[weak self] (data) in
        switch data {
          case .loading: break
          //            self?.loadingSlider.startAnimating()
          //            self?.loadingPopular.startAnimating()
          case .success(let result):
            self?.hideProgressViewPopular()
            self?.movies = result
            self?.popularMovies = result
          //            self?.sliderCollectionView.reloadData()
          //            self?.popularCollectionView.reloadData()
          case .failure(let msg):
            print("Error: \(msg)")
          default:
            print("Nothing happend")
        }
      })
      .disposed(by: disposeBag)

    vm.moviesUpcoming
      .drive(onNext: {[weak self] data in
        switch data {
          case .loading: break
          //            self?.loadingUpcoming.startAnimating()
          case .success(let result):
            print("Jumlah Data Bersih: \(result.count)")
            self?.upcomingMovies = result
            //            self?.upcomingCollectionView.reloadData()
            self?.hideProgressViewUpcoming()
            self?.homeTableView.reloadData()
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
    //    self.loadingSlider.stopAnimating()
    //    self.loadingSlider.hidesWhenStopped = true
    //    self.loadingPopular.stopAnimating()
    //    self.loadingPopular.hidesWhenStopped = true
  }

  private func hideProgressViewUpcoming() {
    //    self.loadingUpcoming.stopAnimating()
    //    self.loadingUpcoming.hidesWhenStopped = true
  }

  private func setupViews() {
    homeTableView.delegate = self
    homeTableView.dataSource = self

    homeTableView.register(headerFooterViewType: HomeTableHeaderView.self)
    homeTableView.register(cellType: SliderTableViewCell.self)
    homeTableView.register(cellType: PopularTableViewCell.self)
    homeTableView.register(cellType: UpcomingTableViewCell.self)
  }
}

extension HomeViewController: UITableViewDelegate {
  public func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    if sections[section] == .popular || sections[section] == .upcoming {
      return 45
    }

    return 0.01
  }

  public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 4
  }

  public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HomeTableHeaderView.reuseIdentifier) as? HomeTableHeaderView

    if sections[section] == .popular {
      header?.labelHeaderTitle.text = "Popular Movies"
      header?.buttonSeeMore.isHidden = true
    } else {
      header?.labelHeaderTitle.text = "Upcoming Movies"
      header?.buttonSeeMore.isHidden = true
    }

    header?.isHidden = sections[section] == .slider ? true : false

    return header
  }
}

extension HomeViewController: UITableViewDataSource {
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    switch sections[indexPath.section] {
      case .slider:
        let cell: SliderTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.safeLayoutArea = view.window?.safeAreaLayoutGuide.layoutFrame
        cell.movies = movies
        cell.movieTapHandler = { [weak self] idMovie in
          guard let self = self else { return }
          let destination = self.router.navigateDetailView(idMovie)
          self.navigationController?.pushViewController(destination, animated: true)
        }
        return cell
      case .popular:
        let cell: PopularTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.movies = popularMovies
        cell.movieTapHandler = { [weak self] idMovie in
          guard let self = self else { return }
          let destination = self.router.navigateDetailView(idMovie)
          self.navigationController?.pushViewController(destination, animated: true)
        }
        return cell
      case .upcoming:
        let cell: UpcomingTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.movie = upcomingMovies
        return cell
    }
  }
}
