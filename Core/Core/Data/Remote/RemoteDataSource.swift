//
//  RemoteDataSource.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import Foundation
import Alamofire
import RxSwift
import AlamofireObjectMapper
import Fortils

protocol RemoteDataSourceProtocol: class {
    func getPopularMovies() -> Observable<[Movie]>
    func getComingSoonMovies() -> Observable<[Movie]>
    func getMovie(_ idMovie: Int) -> Observable<Movie>
    func getCastByIdMovie(_ idMovie: Int) -> Observable<[Cast]>
}

final class RemoteDataSource: NSObject {
    private override init() { }
    static let sharedInstance: RemoteDataSource = RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    
    func getComingSoonMovies() -> Observable<[Movie]> {
        let parameters: Parameters = [
            "api_key": ApiService.apiKey,
            "languange": "en-US",
            "include_adult": "false",
            "region": "US",
            "include_video": "false",
            "page": "1",
            "year": "2021"
        ]
        return Observable<[Movie]>.create { observer in
            if let url = URL(string: Endpoints.Gets.comingsoon.url) {
                Alamofire.request(url, parameters: parameters)
                    .validate()
                    .responseObject { (response: DataResponse<MovieResponse>) in
                        switch response.result {
                            case .success(let value):
                                observer.onNext(value.results ?? [])
                                observer.onCompleted()
                            case .failure:
                                observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getPopularMovies() -> Observable<[Movie]> {
        let parameters: Parameters = [
            "api_key": ApiService.apiKey,
            "languange": "en-US",
            "include_adult": "false",
            "region": "US",
            "include_video": "false",
            "page": "1"
        ]
        return Observable<[Movie]>.create { observer in
            if let url = URL(string: Endpoints.Gets.popular.url) {
                Alamofire.request(url, parameters: parameters)
                    .validate()
                    .responseObject { (response: DataResponse<MovieResponse>) in
                        switch response.result {
                            case .success(let value):
                                observer.onNext(value.results ?? [])
                                observer.onCompleted()
                            case .failure:
                                observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getMovie(_ idMovie: Int) -> Observable<Movie> {
        let parameters: Parameters = [
            "api_key": ApiService.apiKey,
            "languange": "en-US",
            "include_adult": "false",
            "region": "US"
        ]
        return Observable<Movie>.create { observer in
            if let url = URL(string: "\(Endpoints.Gets.detail.url)/\(idMovie)") {
                Alamofire.request(url, parameters: parameters)
                    .validate()
                    .responseObject { (response: DataResponse<Movie>) in
                        switch response.result {
                            case .success(let value):
                                observer.onNext(value)
                                observer.onCompleted()
                            case .failure:
                                observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
    
    func getCastByIdMovie(_ idMovie: Int) -> Observable<[Cast]> {
        let parameters: Parameters = [
            "api_key": ApiService.apiKey
        ]
        return Observable<[Cast]>.create { observer in
            if let url = URL(string: "\(Endpoints.Gets.detail.url)/\(idMovie)/credits") {
                Alamofire.request(url, parameters: parameters)
                    .validate()
                    .responseObject { (response: DataResponse<CastResponse>) in
                        switch response.result {
                            case .success(let value):
                                observer.onNext(value.casts ?? Array())
                                observer.onCompleted()
                            case .failure:
                                observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}
