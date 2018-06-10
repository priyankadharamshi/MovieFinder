//
//  MovieTests.swift
//  MovieFinderTests
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import XCTest
@testable import MovieFinder

class MovieTests: XCTestCase {
    
    var objectUnderTest1 : Movie?
    var objectUnderTest2 : Movie?
    
    override func setUp() {
        super.setUp()
        
        initialiseMovieModelFromJSONFile()
        
        XCTAssertTrue(objectUnderTest1 != nil,"Movie object cannot be nil")
        
    }
    override func tearDown() {
        
        objectUnderTest1 = nil
        super.tearDown()
    }
    
    func test_movieMockExists() {
        
        let movie = objectUnderTest1
        XCTAssertTrue(movie != nil,"Movie object exists")
    }
    
    func test_movieIdExists() {
        
        let movieId = objectUnderTest1?.movieId
        XCTAssertEqual(movieId, 351286)
    }
    func test_movieNameExists() {
        
        let movieName = objectUnderTest1?.title
        XCTAssertEqual(movieName, "Jurassic World: Fallen Kingdom")
    }
    func test_movieVoteAverageExists() {
        
        let voteAverage = objectUnderTest1?.voteAverage
        XCTAssertEqual(voteAverage,6.8)
    }
    
    func test_moviebelongsToCollectionIsTrue() {
        
        XCTAssertTrue(objectUnderTest1?.belongsToCollection != nil, "Movie 1 is part of collection of movies")
        XCTAssertNil(objectUnderTest2?.belongsToCollection, "Movie 2 is not a part of any collection.")
    }
    
}


extension MovieTests {
    
    private func initialiseMovieModelFromJSONFile() {
        
        if let path = Bundle.main.path(forResource: "moviedetail_351286", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let movie1 = try decoder.decode(Movie.self, from: data)
                
                objectUnderTest1 = movie1
                
            } catch  {
                print("Error in decoding JSON \(error)")
                
            }
        }
        
        if let path = Bundle.main.path(forResource: "moviedetail_449176", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let movie2 = try decoder.decode(Movie.self, from: data)
                
                objectUnderTest2 = movie2
                
            } catch  {
                print("Error in decoding JSON \(error)")
                
            }
        }
    }
}

