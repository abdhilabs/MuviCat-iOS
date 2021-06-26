//
//  HomeInteractor.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func getMoviesPopular() -> Observable<[MovieModel]>
    func getMoviesUpcoming() -> Observable<[MovieModel]>
}

class HomeInteractor: HomeUseCase {
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMoviesPopular() -> Observable<[MovieModel]> {
        return repository.getMoviesPopular()
    }
    
    func getMoviesUpcoming() -> Observable<[MovieModel]> {
        return repository.getMoviesComingSoon()
    }
}
