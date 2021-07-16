//
//  MovieModel.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

import Foundation
import Fortils

public struct MovieModel: Equatable, Identifiable {
    
    public let id: Int
    public let title: String
    public let backdropPath: String
    public let posterPath: String
    public let overview: String
    public let voteAverage: Double
    public let voteCount: Int
    public let runtime: Int
    public let releaseDate: String
    public let genres: String
    public let isFavorite: Bool
    
    public static var defaultValue: MovieModel {
        return MovieModel(id: 0, title: "", backdropPath: "", posterPath: "", overview: "", voteAverage: 0.0, voteCount: 0, runtime: 0, releaseDate: "", genres: "", isFavorite: false)
    }
    
    static private let dateTextFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMMM yyyy"
        return formatter
    }()
    
    var dateText: String {
        guard let date = Utils.dateFormatter.date(from: releaseDate) else { return "n/a" }
        return "Release on: " + MovieModel.dateTextFormatter.string(from: date)
    }
    
    public var runtimeText: String {
        let hours = runtime / 60
        let minutes = runtime / 60 * 60
        return "\(hours)h \(minutes)m"
    }
    
    var ratingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "⭐️"
        }
        return ratingText
    }
    
    var scoreText: String {
        guard ratingText.count > 0 else {
            return "n/a"
        }
        return "\(ratingText.count)/10"
    }
}

struct GenreModel: Equatable, Identifiable {
    let id: Int
    let name: String
}
