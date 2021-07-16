//
//  FavoriteViewModel.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import RxSwift
import RxRelay
import RxCocoa
import Core

public class FavoriteViewModel: ObservableObject {
    private let favoriteUseCase: FavoriteUseCase
    private let disposeBag = DisposeBag()
    
    public init(favoriteUseCase: FavoriteUseCase) {
        self.favoriteUseCase = favoriteUseCase
        self.getFavoriteMovies()
    }
    
    private let _moviesFavorite: BehaviorRelay<[MovieModel]> = BehaviorRelay<[MovieModel]>(value: [])
    var moviesFavorite: Driver<[MovieModel]> {
        return _moviesFavorite.asDriver()
    }
    
    private let _updateFavorite: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    var updateFavorite: Driver<Bool> {
        return _updateFavorite.asDriver()
    }
    
    func getFavoriteMovies() {
        favoriteUseCase.getMoviesFavorite()
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self._moviesFavorite.accept(result)
            } onError: { error in
                print("Error: \(error.localizedDescription)")
            } onCompleted: {
            }.disposed(by: disposeBag)
    }
    
    func searchFavoriteMovies(query search: String) {
        favoriteUseCase.searchMoviesFavorite(query: search)
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self._moviesFavorite.accept(result)
            } onError: { error in
                print("Error: \(error.localizedDescription)")
            } onCompleted: {
            }.disposed(by: disposeBag)
    }
    
    func updateMovieById(_ idMovie: Int, _ isFav: Bool) {
        favoriteUseCase.updateFavoriteMovieById(idMovie, isFav)
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self._updateFavorite.accept(result)
            } onError: { error in
                print("Error: \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }
}
