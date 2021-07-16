//
//  SearchInteractor.swift
//  MuviCat
//
//  Created by Abdhi on 20/06/21.
//

import Foundation
import RxSwift

public protocol SearchUseCase {
    func searchMoviesPopular(query search: String) -> Observable<[MovieModel]>
}

public class SearchInteractor: SearchUseCase {
    private let repository: MovieRepositoryProtocol
    
    required init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    public func searchMoviesPopular(query search: String) -> Observable<[MovieModel]> {
        return repository.searchMoviesPopular(query: search)
    }
}
