//
//  HomeInteractor.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import Foundation
import RxSwift

public protocol HomeUseCase {
    func getMoviesPopular() -> Observable<[MovieModel]>
    func getMoviesUpcoming() -> Observable<[MovieModel]>
}

public class HomeInteractor: HomeUseCase {
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getMoviesPopular() -> Observable<[MovieModel]> {
        return repository.getMoviesPopular()
    }
    
    public func getMoviesUpcoming() -> Observable<[MovieModel]> {
        return repository.getMoviesComingSoon()
    }
}
