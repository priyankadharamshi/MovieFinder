//
//  MovieModel.swift
//  MovieFinder
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import Foundation
import UIKit

struct MovieModel: Codable {
    let movies: [Movie]
    private let page, totalResults: Int
    private let dates: Dates
    private let totalPages: Int
    
    private enum CodingKeys: String, CodingKey {
        case movies = "results"
        case page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}

struct Dates: Codable {
    let maximum, minimum: String
}

struct Movie: Codable {
   
    let voteCount, movieId: Int
    let video: Bool
    let voteAverage: Double
    let title: String
    let popularity: Double?
    
    let originalLanguage: OriginalLanguage
    let originalTitle: String
    let genreIDS: [Int]?
    let backdropPath: String?
    let adult: Bool
    let overview, releaseDate: String
    
    // Detail movie model - Making optional to support both models
    let belongsToCollection: BelongsToCollection?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    
    let imdbID: String?
    
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    
    let revenue : Int?
    let runtime : Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    
    var posterImagePath : String? {
        
        get {
            
            if let posterPath = posterPath {
                
                return RequestURLProvider.imageBaseURL + posterPath
            }
            return nil
        }
    }
    
    // MARK: Private properties
    private let posterPath: String?
    
    private enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case movieId = "id"
        case video
        case voteAverage = "vote_average"
        case title, popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIDS = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult, overview
        case releaseDate = "release_date"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage
        case imdbID = "imdb_id"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline
    }
}

enum OriginalLanguage: String, Codable {
    case cn = "cn"
    case en = "en"
}

struct BelongsToCollection: Codable {
    let collectionId: Int
    let collectionName, posterPath, backdropPath: String
    
    enum CodingKeys: String, CodingKey {
        case collectionId = "id"
        case collectionName = "name"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let logoPath: String?
    let name, originCountry: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable {
    let iso3166_1, name: String
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Codable {
    let iso639_1, name: String
    
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case name
    }
}
