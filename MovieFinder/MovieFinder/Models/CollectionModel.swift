//
//  CollectionModel.swift
//  MovieFinder
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import Foundation

struct Collection: Codable {
    let collectionId: Int
    let name : String
    let overview, posterPath, backdropPath: String?
    let movieParts: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case collectionId = "id"
        case name, overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case movieParts = "parts"
    }
}
