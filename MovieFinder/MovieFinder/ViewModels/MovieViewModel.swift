//
//  MovieViewModel.swift
//  MovieFinder
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import Foundation

typealias MovieViewModelCompletion = ([Movie]) -> Void
typealias MovieViewModelError = (Error?) -> Void

protocol MovieDataService {
    func fetchNowPlayingList(completionBlock: @escaping MovieViewModelCompletion, errorBlock : @escaping MovieViewModelError) -> Void
    func fetchMovieDetail(_ forMovieId : Int, completionBlock: @escaping MovieViewModelCompletion, errorBlock : @escaping MovieViewModelError) -> Void
}

class MovieViewModel : NSObject, MovieDataService {
    
    var movieList: MovieModel? = nil
    
    private var networkManager = NetworkManager()
    private var successBlock : MovieViewModelCompletion? = nil
    private var failureBlock : MovieViewModelError? = nil
    
    func fetchNowPlayingList(completionBlock: @escaping MovieViewModelCompletion, errorBlock: @escaping MovieViewModelError) {
        self.successBlock = completionBlock
        self.failureBlock = errorBlock
        networkManager.getNowPlayingMovieList( completion: { [weak self] (data, error) in
            
            guard let `self` = self else {return}
            
            if let error = error {
                self.failureBlock!(error)
            }
            if let data = data {
                do {
                    let movieModel = try JSONDecoder().decode(MovieModel.self, from: data)
                    self.successBlock!(movieModel.movies)
                }catch {
                    self.failureBlock!(nil)
                }
            }
        })
        
    }
    
    
    func fetchMovieDetail(_ forMovieId: Int, completionBlock: @escaping MovieViewModelCompletion, errorBlock: @escaping MovieViewModelError) {
        
        self.successBlock = completionBlock
        self.failureBlock = errorBlock
        networkManager.getNowPlayingMovieList( completion: { [weak self] (data, error) in
            
            guard let `self` = self else {return}
            
            if let error = error {
                self.failureBlock!(error)
            }
            
            if let data = data {
                do {
                    let movie = try JSONDecoder().decode(Movie.self, from: data)
                    self.successBlock!([movie])
                    
                } catch {
                    self.failureBlock!(nil)
                }
            }
        })
    }
    
}
