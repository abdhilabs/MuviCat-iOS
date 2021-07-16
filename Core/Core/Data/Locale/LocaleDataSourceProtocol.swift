//
//  LocaleDataSourceProtocol.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import Foundation
import RealmSwift
import RxSwift
import Fortils

protocol LocaleDataSourceProtocol: class {
    func getPopularMovies() -> Observable<[MovieEntity]>
    func getPopularMovieById(_ idMovie: Int) -> Observable<MovieEntity>
    func getFavoriteMovies() -> Observable<[MovieEntity]>
    func searchFavoriteMovies(query search: String) -> Observable<[MovieEntity]>
    func searchPopularMovies(query search: String) -> Observable<[MovieEntity]>
    func addPopularMovies(from movies: [MovieEntity]) -> Observable<Bool>
    func updatePopularMovie(from movie: MovieEntity) -> Observable<Bool>
    func updateFavoriteMovie(_ idMovie: Int, _ isFav: Bool) -> Observable<Bool>
}

final class LocaleDataSource: NSObject {
    private let realm: Realm?
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    static let sharedInstance: (Realm?) -> LocaleDataSource = {
        realmDatabase in return LocaleDataSource(realm: realmDatabase)
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    func searchFavoriteMovies(query search: String) -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create { observer in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter(NSPredicate(format: "title CONTAINS %@", search))
                        .filter(NSPredicate(format: "isFavorite == \(true)"))
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(movies.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getPopularMovieById(_ idMovie: Int) -> Observable<MovieEntity> {
        return Observable<MovieEntity>.create { observer in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter(NSPredicate(format: "id == \(idMovie)"))
                }()
                if let movie = movies.first {
                    observer.onNext(movie)
                    observer.onCompleted()
                } else {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func searchPopularMovies(query search: String) -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create { observer in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter(NSPredicate(format: "title CONTAINS %@", search))
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(movies.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getPopularMovies() -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create { observer in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(movies.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func getFavoriteMovies() -> Observable<[MovieEntity]> {
        return Observable<[MovieEntity]>.create { observer in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter(NSPredicate(format: "isFavorite == \(true)"))
                        .sorted(byKeyPath: "title", ascending: true)
                }()
                observer.onNext(movies.toArray(ofType: MovieEntity.self))
                observer.onCompleted()
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func addPopularMovies(from movies: [MovieEntity]) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                do {
                    try realm.write {
                        for movie in movies {
                            realm.add(movie, update: .all)
                        }
                        observer.onNext(true)
                        observer.onCompleted()
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func updatePopularMovie(from movie: MovieEntity) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter(NSPredicate(format: "id == \(movie.id)"))
                }()
                do {
                    if let item = movies.first {
                        try realm.write {
                            item.genres = movie.genres
                            item.runtime = movie.runtime
                            observer.onNext(true)
                            observer.onCompleted()
                        }
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
    
    func updateFavoriteMovie(_ idMovie: Int, _ isFav: Bool) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            if let realm = self.realm {
                let movies: Results<MovieEntity> = {
                    realm.objects(MovieEntity.self)
                        .filter(NSPredicate(format: "id == \(idMovie)"))
                }()
                do {
                    if let movie = movies.first {
                        try realm.write {
                            movie.isFavorite = isFav
                            observer.onNext(true)
                            observer.onCompleted()
                        }
                    }
                } catch {
                    observer.onError(DatabaseError.requestFailed)
                }
            } else {
                observer.onError(DatabaseError.invalidInstance)
            }
            return Disposables.create()
        }
    }
}

extension Results {
    func toArray<T>(ofType: T.Type) -> [T] {
        var array = [T]()
        for index in 0 ..< count {
            if let result = self[index] as? T {
                array.append(result)
            }
        }
        return array
    }
}
