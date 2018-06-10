//
//  MovieModelTests.swift
//  MovieFinderTests
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import XCTest
@testable import MovieFinder

class MovieModelTests: XCTestCase {
    
    var objectUnderTest : MovieModel?
    
    override func setUp() {
        super.setUp()
        
        let model = initialiseMovieModelFromJSONFile()
        objectUnderTest = model
        
        XCTAssertTrue(objectUnderTest != nil,"Movie object cannot be nil")
        
    }
    override func tearDown() {
        
        objectUnderTest = nil
        super.tearDown()
    }
    
    func test_movieModelMockExists() {
        
        let movieModel = objectUnderTest
        XCTAssertTrue(movieModel != nil,"Movie Model object exists")
    }
    
    func test_movieListExists() {
        let movieList = objectUnderTest?.movies
        XCTAssertTrue(movieList != nil, "Movie list exists")
    }
    
    func test_movieCountExists() {
        
        if let movieList = objectUnderTest?.movies {
            XCTAssertTrue(movieList.count > 0,"Movie list count is greater than 0")
        }
    }
    
}
extension MovieModelTests {
    
    private func initialiseMovieModelFromJSONFile() -> MovieModel? {
        
        if let path = Bundle.main.path(forResource: "movie_nowplaying", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let movieList = try decoder.decode(MovieModel.self, from: data)
                
                return movieList
                
            } catch  {
                print("Error in decoding JSON \(error)")
                return nil
            }
        }
        return nil
    }
}

