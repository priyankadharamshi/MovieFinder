//
//  CollectionViewModel.swift
//  MovieFinder
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import Foundation

import Foundation
import UIKit
import CoreLocation

typealias CollectionViewModelCompletion = (Collection?) -> Void
typealias CollectionViewModelError = (Error?) -> Void

protocol CollectionDataService {
    func fetchCollectionDetail(_ forCollectionId : Int, completionBlock: @escaping CollectionViewModelCompletion, errorBlock : @escaping CollectionViewModelError) -> Void
}

class CollectionViewModel : NSObject, CollectionDataService {
    
    var collection: Collection? = nil
    
    static let defaultErrorMessage = "Error in retrieving data from server."
    
    private var networkManager = NetworkManager()
    private var successBlock : CollectionViewModelCompletion? = nil
    private var failureBlock : CollectionViewModelError? = nil
    
    func fetchCollectionDetail(_ forCollectionId: Int, completionBlock: @escaping CollectionViewModelCompletion, errorBlock: @escaping CollectionViewModelError) {
        
        self.successBlock = completionBlock
        self.failureBlock = errorBlock
        networkManager.getCollectionDetails(forCollectionId, completion: { [weak self] (data, error) in
            
            guard let `self` = self else {return}
            
            if let error = error {
                self.failureBlock!(error)
            }
            
            if let data = data {
                do {
                    let collection = try JSONDecoder().decode(Collection.self, from: data)
                    self.successBlock!(collection)
                    
                } catch {
                    self.failureBlock!(nil)
                }
            }
        })
    }
    
}
