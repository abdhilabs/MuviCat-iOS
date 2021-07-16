//
//  HomeViewModel.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import RxSwift
import RxRelay
import RxCocoa
import Core
import Fortils

public class HomeViewModel: ObservableObject {
    
    private let homeUseCase: HomeUseCase
    private let disposeBag = DisposeBag()
    
    public init(homeUseCase: HomeUseCase) {
        self.homeUseCase = homeUseCase
        getMoviesPopular()
        getMoviesUpcoming()
    }

    private let _moviesPopular = BehaviorRelay<ResultState<[MovieModel], String>?>(value: nil)
    var moviesPopular: Driver<ResultState<[MovieModel], String>?> {
        return _moviesPopular.asDriver()
    }
    
    private let _moviesUpcoming = BehaviorRelay<ResultState<[MovieModel], String>?>(value: nil)
    var moviesUpcoming: Driver<ResultState<[MovieModel], String>?> {
        return _moviesUpcoming.asDriver()
    }
    
    func getMoviesPopular() {
        self._moviesPopular.accept(ResultState.loading)
        homeUseCase.getMoviesPopular()
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self._moviesPopular.accept(ResultState.success(result))
            } onError: { error in
                self._moviesPopular.accept(ResultState.failure(error.localizedDescription))
            }.disposed(by: disposeBag)
    }
    
    func getMoviesUpcoming() {
        self._moviesUpcoming.accept(ResultState.loading)
        homeUseCase.getMoviesUpcoming()
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self._moviesUpcoming.accept(ResultState.success(result))
            } onError: { error in
                self._moviesUpcoming.accept(ResultState.failure(error.localizedDescription))
            }.disposed(by: disposeBag)
    }
}
