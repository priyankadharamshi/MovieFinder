//
//  MovieViewModelTest.swift
//  MovieFinderTests
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import XCTest

@testable import MovieFinder

class MovieViewModelTests: XCTestCase {
    
    var objectUnderTest : MockMovieViewModel?
    var movieList : [Movie]? = nil
    
    override func setUp() {
        super.setUp()
        objectUnderTest = MockMovieViewModel()
    }
    
    override func tearDown() {
        
        objectUnderTest = nil
        movieList = nil
        super.tearDown()
    }
    
    func test_movieViewModelMockExists() {
        
        let mockViewModel = objectUnderTest
        XCTAssertTrue(mockViewModel != nil,"Movie View Model object exists")
    }
    
    func test_mockMovieListExists() {
        
        objectUnderTest?.fetchNowPlayingList(completionBlock: { (movieList) in
            self.movieList = movieList
        }, errorBlock: { (error) in
            self.movieList = nil
        })
        
        XCTAssertEqual(objectUnderTest?.movieList?.movies.count, self.movieList?.count)

    }
    
    func test_mockMovieDetailExists() {
        
        let movieId = 351286
        objectUnderTest?.fetchMovieDetail(movieId, completionBlock:{ (movieList) in
            self.movieList = movieList
        }, errorBlock: { (error) in
            self.movieList = nil
        })
        
        XCTAssertEqual(self.movieList?.count, 1)
        XCTAssertEqual(self.movieList?.first?.movieId, movieId)
        
    }
    
}
