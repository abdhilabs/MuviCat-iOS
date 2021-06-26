//
//  MovieResponse.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import Foundation
import ObjectMapper

class MovieResponse: Mappable {
    var results: [Movie]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        results <- map["results"]
    }
}

class Movie: Mappable {
    var id: Int?
    var title: String?
    var backdropPath: String?
    var posterPath: String?
    var overview: String?
    var voteAverage: Double?
    var voteCount: Int?
    var runtime: Int?
    var releaseDate: String?
    var genres: [Genre]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["original_title"]
        backdropPath <- map["backdrop_path"]
        posterPath <- map["poster_path"]
        overview <- map["overview"]
        voteAverage <- map["vote_average"]
        voteCount <- map["vote_count"]
        runtime <- map["runtime"]
        releaseDate <- map["release_date"]
        genres <- map["genres"]
    }
}

class Genre: Mappable {
    var id: Int?
    var name: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
