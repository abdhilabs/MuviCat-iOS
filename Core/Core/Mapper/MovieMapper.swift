//
//  MovieMapper.swift
//  MuviCat
//
//  Created by Abdhi on 18/06/21.
//

final class MovieMapper {
    
    // MARK: - Mapping to Domain
    
    static func mapMovieResponsesToDomains(input movieResponse: [Movie]) -> [MovieModel] {
        return movieResponse.map { result in
            return MovieModel(
                id: result.id ?? 0,
                title: result.title ?? "",
                backdropPath: result.backdropPath ?? "",
                posterPath: result.posterPath ?? "",
                overview: result.overview ?? "",
                voteAverage: result.voteAverage ?? 0.0,
                voteCount: result.voteCount ?? 0,
                runtime: result.runtime ?? 0,
                releaseDate: result.releaseDate ?? "",
                genres: self.mappingGenres(input: result.genres ?? []),
                isFavorite: false)
        }
    }
    
    static func mapMovieEntitiesToDomains(input movieEntities: [MovieEntity]) -> [MovieModel] {
        return movieEntities.map { result in
            return MovieModel(
                id: result.id ,
                title: result.title,
                backdropPath: result.backdropPath,
                posterPath: result.posterPath,
                overview: result.overview,
                voteAverage: result.voteAverage,
                voteCount: result.voteCount,
                runtime: result.runtime,
                releaseDate: result.releaseDate,
                genres: result.genres,
                isFavorite: result.isFavorite)
        }
    }
    
    static func mapMovieResponseToDomain(input movieResponse: Movie) -> MovieModel {
        let result = movieResponse
        return MovieModel(
            id: result.id ?? 0,
            title: result.title ?? "",
            backdropPath: result.backdropPath ?? "",
            posterPath: result.posterPath ?? "",
            overview: result.overview ?? "",
            voteAverage: result.voteAverage ?? 0.0,
            voteCount: result.voteCount ?? 0,
            runtime: result.runtime ?? 0,
            releaseDate: result.releaseDate ?? "",
            genres: self.mappingGenres(input: result.genres ?? []),
            isFavorite: false)
    }
    
    static func mapMovieEntitiesToDomain(input movieEntities: MovieEntity) -> MovieModel {
        let result = movieEntities
        return MovieModel(
            id: result.id,
            title: result.title,
            backdropPath: result.backdropPath,
            posterPath: result.posterPath,
            overview: result.overview,
            voteAverage: result.voteAverage,
            voteCount: result.voteCount,
            runtime: result.runtime,
            releaseDate: result.releaseDate,
            genres: result.genres,
            isFavorite: result.isFavorite)
    }
    
    // MARK: - Mapping to Entities
    
    static func mapMovieResponsesToEntities(input movieResponse: [Movie]) -> [MovieEntity] {
        return movieResponse.map { result in
            let newMovie = MovieEntity()
            newMovie.id = result.id ?? 0
            newMovie.title = result.title ?? ""
            newMovie.backdropPath = result.backdropPath ?? ""
            newMovie.posterPath = result.posterPath ?? ""
            newMovie.overview = result.overview ?? ""
            newMovie.voteAverage = result.voteAverage ?? 0.0
            newMovie.voteCount = result.voteCount ?? 0
            newMovie.runtime = result.runtime ?? 0
            newMovie.releaseDate = result.releaseDate ?? ""
            return newMovie
        }
    }
    
    static func mapMovieModelToEntity(input movieResponse: MovieModel) -> MovieEntity {
        let result = movieResponse
        let newMovie = MovieEntity()
        newMovie.id = result.id
        newMovie.title = result.title
        newMovie.backdropPath = result.backdropPath
        newMovie.posterPath = result.posterPath
        newMovie.overview = result.overview
        newMovie.voteAverage = result.voteAverage
        newMovie.voteCount = result.voteCount
        newMovie.runtime = result.runtime
        newMovie.releaseDate = result.releaseDate
        newMovie.genres = result.genres
        return newMovie
    }
    
    private static func mappingGenres(input genresResponse: [Genre]) -> String {
        var genre = [String]()
        for i in genresResponse {
            genre.append(i.name ?? "")
        }
        return genre.joined(separator: " • ")
    }
}
