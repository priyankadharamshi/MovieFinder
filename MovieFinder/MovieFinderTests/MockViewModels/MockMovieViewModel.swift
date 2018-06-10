//
//  MovieViewModelTests.swift
//  MovieFinderTests
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import Foundation
@testable import MovieFinder

class MockMovieViewModel : MovieViewModel {
    
    override func fetchNowPlayingList(completionBlock: @escaping MovieViewModelCompletion, errorBlock: @escaping MovieViewModelError) {
        if let path = Bundle.main.path(forResource: "movie_nowplaying", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let list = try decoder.decode(MovieModel.self, from: data)
                completionBlock(list.movies)
                self.movieList = list
            } catch  {
                print("Error in decoding JSON \(error)")
                errorBlock(error)
            }
        }
    }
    
    override func fetchMovieDetail(_ forMovieId: Int, completionBlock: @escaping MovieViewModelCompletion, errorBlock: @escaping MovieViewModelError) {
        if let path = Bundle.main.path(forResource: "moviedetail_\(forMovieId)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let movie = try decoder.decode(Movie.self, from: data)
                completionBlock([movie])
            } catch  {
                print("Error in decoding JSON \(error)")
                errorBlock(error)
            }
        }
    }
    
    
}
