//
//  CastMapper.swift
//  MuviCat
//
//  Created by Abdhi on 25/06/21.
//

import Foundation

final class CastMapper {
    
    static func mapCastResponseToCastModel(input castResponse: [Cast]) -> [CastModel] {
        return castResponse.map { result in
            return CastModel(
                id: result.id ?? 0,
                name: result.name ?? "",
                profilePath: result.profilePath ?? "")
        }
    }
    
}
