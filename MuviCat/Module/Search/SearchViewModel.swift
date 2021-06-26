//
//  SearchViewModel.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import RxSwift
import RxRelay
import RxCocoa

class SearchViewModel: ObservableObject {
    private let searchUseCase: SearchUseCase
    private let disposeBag = DisposeBag()
    
    init(searchUseCase: SearchUseCase) {
        self.searchUseCase = searchUseCase
        
    }
    
    private let _moviesSearch: BehaviorRelay<[MovieModel]> = BehaviorRelay<[MovieModel]>(value: [])

    var moviesSearch: Driver<[MovieModel]> {
        return _moviesSearch.asDriver()
    }
    
    func searchMoviesPopular(query search: String) {
        searchUseCase.searchMoviesPopular(query: search)
            .observeOn(MainScheduler.instance)
            .subscribe { result in
                self._moviesSearch.accept(result)
            } onError: { error in
                print("Error: \(error.localizedDescription)")
            } onCompleted: {
            }.disposed(by: disposeBag)
    }
}
