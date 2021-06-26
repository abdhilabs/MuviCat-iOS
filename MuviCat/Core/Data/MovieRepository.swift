//
//  MovieRepository.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import Foundation
import RxSwift

protocol MovieRepositoryProtocol {
    func getMoviesPopular() -> Observable<[MovieModel]>
    func getMoviesComingSoon() -> Observable<[MovieModel]>
    func getMovieById(_ idMovie: Int) -> Observable<MovieModel>
    func getMoviesFavorite() -> Observable<[MovieModel]>
    func getCastByIdMovie(_ idMovie: Int) -> Observable<[CastModel]>
    func searchMoviesFavorite(query search: String) -> Observable<[MovieModel]>
    func searchMoviesPopular(query search: String) -> Observable<[MovieModel]>
    func updateFavoriteMovie(_ idMovie: Int, _ isFav: Bool) -> Observable<Bool>
}

final class MovieRepository: NSObject {
    
    typealias MovieInstance = (LocaleDataSource, RemoteDataSource) -> MovieRepository
    
    fileprivate let remote: RemoteDataSource
    fileprivate let locale: LocaleDataSource
    
    private init(locale: LocaleDataSource, remote: RemoteDataSource) {
        self.locale = locale
        self.remote = remote
    }
    
    static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
        return MovieRepository(locale: localeRepo, remote: remoteRepo)
    }
}

extension MovieRepository: MovieRepositoryProtocol {
    func getCastByIdMovie(_ idMovie: Int) -> Observable<[CastModel]> {
        return self.remote.getCastByIdMovie(idMovie)
            .map { CastMapper.mapCastResponseToCastModel(input: $0) }
    }
    
    func searchMoviesFavorite(query search: String) -> Observable<[MovieModel]> {
        return self.locale.searchFavoriteMovies(query: search)
            .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
//            .filter { !$0.isEmpty }
//            .ifEmpty(switchTo: self.locale.getFavoriteMovies()
//                        .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
//            )
    }
    
    func getMovieById(_ idMovie: Int) -> Observable<MovieModel> {
        return self.locale.getPopularMovieById(idMovie)
            .map { MovieMapper.mapMovieEntitiesToDomain(input: $0) }
            .filter { !$0.genres.isEmpty }
            .ifEmpty(switchTo: self.remote.getMovie(idMovie)
                        .map { MovieMapper.mapMovieResponseToDomain(input: $0) }
                        .map { MovieMapper.mapMovieModelToEntity(input: $0) }
                        .flatMap { self.locale.updatePopularMovie(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self .locale.getPopularMovieById(idMovie)
                            .map { MovieMapper.mapMovieEntitiesToDomain(input: $0) }
                        }
            )
    }
    
    func getMoviesPopular() -> Observable<[MovieModel]> {
        return self.locale.getPopularMovies()
            .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            .filter { !$0.isEmpty }
            .ifEmpty(switchTo: self.remote.getPopularMovies()
                        .map { MovieMapper.mapMovieResponsesToEntities(input: $0) }
                        .flatMap { self.locale.addPopularMovies(from: $0) }
                        .filter { $0 }
                        .flatMap { _ in self .locale.getPopularMovies()
                            .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
                        }
            )
    }
    
    func getMoviesComingSoon() -> Observable<[MovieModel]> {
        return self.remote.getComingSoonMovies()
            .map { MovieMapper.mapMovieResponsesToDomains(input: $0) }
    }
    
    func getMoviesFavorite() -> Observable<[MovieModel]> {
        return self.locale.getFavoriteMovies()
            .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
    }
    
    func searchMoviesPopular(query search: String) -> Observable<[MovieModel]> {
        return self.locale.searchPopularMovies(query: search)
            .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            .filter { !$0.isEmpty }
            .ifEmpty(switchTo: self.locale.getPopularMovies()
                        .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
            )
    }
    
    func updateFavoriteMovie(_ idMovie: Int, _ isFav: Bool) -> Observable<Bool> {
        return self.locale.updateFavoriteMovie(idMovie, isFav)
    }
}
