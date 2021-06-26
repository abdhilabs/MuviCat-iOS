//
//  DetailInteractor.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import Foundation
import RxSwift

protocol DetailUseCase {
    func getMovieById(_ idMovie: Int) -> Observable<MovieModel>
    func getCastsByIdMovie(_ idMovie: Int) -> Observable<[CastModel]>
    func updateFavoriteMovieById(_ idMovie: Int, _ isFav: Bool) -> Observable<Bool>
}

class DetailInteractor: DetailUseCase {
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getMovieById(_ idMovie: Int) -> Observable<MovieModel> {
        return repository.getMovieById(idMovie)
    }
    
    func getCastsByIdMovie(_ idMovie: Int) -> Observable<[CastModel]> {
        return repository.getCastByIdMovie(idMovie)
    }
    
    func updateFavoriteMovieById(_ idMovie: Int, _ isFav: Bool) -> Observable<Bool> {
        return repository.updateFavoriteMovie(idMovie, isFav)
    }
}
