//
//  DetailRouter.swift
//  Detail
//
//  Created by Abdhi on 15/07/21.
//

import Core
import UIKit

public class DetailRouter {
    public init() {}
    
    public func navigateDetailView(_ idMovie: Int) -> DetailViewController {
        let useCase = Injection.init().provideDetail()
        let detailViewModel = DetailViewModel(detailUseCase: useCase)
        let detail = DetailViewController(viewModel: detailViewModel)
        detail.idMovie = idMovie
        return detail
    }
}
