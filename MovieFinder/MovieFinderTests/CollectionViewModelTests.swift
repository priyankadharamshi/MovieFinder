//
//  CollectionViewModelTests.swift
//  CollectionFinderTests
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import XCTest
@testable import MovieFinder

class CollectionViewModelTests: XCTestCase {
    
    var objectUnderTest : MockCollectionViewModel?
    var collection : MovieFinder.Collection?
    
    override func setUp() {
        super.setUp()
        objectUnderTest = MockCollectionViewModel()
    }
    
    override func tearDown() {
        
        objectUnderTest = nil
        collection = nil
        super.tearDown()
    }
    
    func test_collectionViewModelMockExists() {
        
        let mockViewModel = objectUnderTest
        XCTAssertTrue(mockViewModel != nil,"Collection View Model object exists")
    }

    
    func test_mockCollectionDetailExists() {
        
        let collectionId = 328
        objectUnderTest?.fetchCollectionDetail(collectionId, completionBlock:{ (collection) in
            self.collection = collection
        }, errorBlock: { (error) in
            self.collection = nil
        })
        
        XCTAssertTrue(self.collection != nil)
        XCTAssertEqual(self.collection?.collectionId, collectionId)
        
    }
    
}
