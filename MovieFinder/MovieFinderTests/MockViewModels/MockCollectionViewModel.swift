//
//  MockCollectionViewModel.swift
//  CollectionFinderTests
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import Foundation
@testable import MovieFinder

class MockCollectionViewModel : CollectionViewModel {
    
    override func fetchCollectionDetail(_ forCollectionId: Int, completionBlock: @escaping CollectionViewModelCompletion, errorBlock: @escaping CollectionViewModelError) {
        if let path = Bundle.main.path(forResource: "collection_\(forCollectionId)", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let collection = try decoder.decode(Collection.self, from: data)
                completionBlock(collection)
            } catch  {
                print("Error in decoding JSON \(error)")
                errorBlock(error)
            }
        }
    }
    
    
}
