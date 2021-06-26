//
//  ApiService.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import Foundation

struct ApiService {
    static let baseUrl = "https://api.themoviedb.org/3"
    static let apiKey = "995351073e521ebe15db309b37cc0ca2"
}

protocol Endpoint {
    var url: String { get }
}

enum Endpoints {
    
    enum Gets: Endpoint {
        case popular
        case comingsoon
        case detail
        
        public var url: String{
            switch self {
                case .comingsoon: return "\(ApiService.baseUrl)/movie/upcoming"
                case .popular: return "\(ApiService.baseUrl)/movie/popular"
                case .detail: return "\(ApiService.baseUrl)/movie"
            }
        }
    }
}
