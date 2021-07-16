//
//  FavoriteInteractor.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import Foundation
import RxSwift

public protocol FavoriteUseCase {
    func getMoviesFavorite() -> Observable<[MovieModel]>
    func searchMoviesFavorite(query search: String) -> Observable<[MovieModel]>
    func updateFavoriteMovieById(_ idMovie: Int, _ isFav: Bool) -> Observable<Bool>
}

public class FavoriteInteractor: FavoriteUseCase {
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    public func getMoviesFavorite() -> Observable<[MovieModel]> {
        return repository.getMoviesFavorite()
    }
    
    public func searchMoviesFavorite(query search: String) -> Observable<[MovieModel]> {
        return repository.searchMoviesFavorite(query: search)
    }
    
    public func updateFavoriteMovieById(_ idMovie: Int, _ isFav: Bool) -> Observable<Bool> {
        return repository.updateFavoriteMovie(idMovie, isFav)
    }
}
