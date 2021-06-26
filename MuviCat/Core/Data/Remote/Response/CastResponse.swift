//
//  CastResponse.swift
//  MuviCat
//
//  Created by Abdhi on 25/06/21.
//

import Foundation
import ObjectMapper

class CastResponse: Mappable {
    var casts: [Cast]?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        casts <- map["cast"]
    }
}

class Cast: Mappable {
    var id: Int?
    var name: String?
    var profilePath: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        profilePath <- map["profile_path"]
    }
}
