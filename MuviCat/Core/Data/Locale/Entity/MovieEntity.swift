//
//  MovieEntity.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import Foundation
import RealmSwift

class MovieEntity: Object {

    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var backdropPath: String = ""
    @objc dynamic var posterPath: String = ""
    @objc dynamic var overview: String = ""
    @objc dynamic var voteAverage: Double = 0.0
    @objc dynamic var voteCount: Int = 0
    @objc dynamic var runtime: Int = 0
    @objc dynamic var releaseDate: String = ""
    @objc dynamic var genres: String = ""
    @objc dynamic var isFavorite: Bool = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
