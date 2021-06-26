//
//  DetailViewModel.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import RxSwift
import RxRelay
import RxCocoa

class DetailViewModel: ObservableObject {
    private let detailUseCase: DetailUseCase
    private let disposeBag = DisposeBag()
    
    init(detailUseCase: DetailUseCase) {
        self.detailUseCase = detailUseCase
    }
    
    private let _movie = BehaviorRelay<MovieModel>(value: MovieModel.defaultValue)
    var movie: Driver<MovieModel> {
        return _movie.asDriver()
    }
    
    private let _cast = BehaviorRelay<[CastModel]>(value: [])
    var cast: Driver<[CastModel]> {
        return _cast.asDriver()
    }
    
    func getMovieById(_ idMovie: Int) {
        detailUseCase.getMovieById(idMovie)
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self._movie.accept(result)
            } onError: { error in
                print("Error: \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }
    
    func updateMovieById(_ idMovie: Int, _ isFav: Bool) {
        detailUseCase.updateFavoriteMovieById(idMovie, isFav)
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                print("Status update: \(result)")
            } onError: { error in
                print("Error: \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }
    
    func getCastsByIdMovie(_ idMovie: Int) {
        detailUseCase.getCastsByIdMovie(idMovie)
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self._cast.accept(result)
            } onError: { error in
                print("Error: \(error.localizedDescription)")
            }.disposed(by: disposeBag)
    }
}
