//
//  FavoriteInteractor.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import Foundation
import RxSwift

protocol FavoriteUseCase {
    func getMoviesFavorite() -> Observable<[MovieModel]>
    func searchMoviesFavorite(query search: String) -> Observable<[MovieModel]>
    func updateFavoriteMovieById(_ idMovie: Int, _ isFav: Bool) -> Observable<Bool>
}

class FavoriteInteractor: FavoriteUseCase {
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMoviesFavorite() -> Observable<[MovieModel]> {
        return repository.getMoviesFavorite()
    }
    
    func searchMoviesFavorite(query search: String) -> Observable<[MovieModel]> {
        return repository.searchMoviesFavorite(query: search)
    }
    
    func updateFavoriteMovieById(_ idMovie: Int, _ isFav: Bool) -> Observable<Bool> {
        return repository.updateFavoriteMovie(idMovie, isFav)
    }
}
