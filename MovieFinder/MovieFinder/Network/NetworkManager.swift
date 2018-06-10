//
//  NetworkManager.swift
//  MovieFinder
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import Foundation

class NetworkManager {
    
    func getNowPlayingMovieList(completion : @escaping (_ results: Data?, _ error : NSError?) -> Void){
        
        guard let searchURL = movieURLForNowPlaying() else {
            let APIError = NSError(domain: "MovieDB", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
            completion(nil, APIError)
            return
        }
        
        let searchRequest = URLRequest(url: searchURL)
        
        URLSession.shared.dataTask(with: searchRequest, completionHandler: { (data, response, error) in
            
            if let _ = error {
                let APIError = NSError(domain: "MovieDB", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
                OperationQueue.main.addOperation({
                    completion(nil, APIError)
                })
                return
            }
            
            guard let _ = response as? HTTPURLResponse,
                let data = data else {
                    let APIError = NSError(domain: "MovieDB", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
                    OperationQueue.main.addOperation({
                        completion(nil, APIError)
                    })
                    return
            }
            
         
                
            completion(data,nil)
                
          
            
            
        }) .resume()
    }
    
    func getMovieDetails(_ movieId: Int, completion : @escaping (_ results: Data?, _ error : NSError?) -> Void){
        
        guard let searchURL = movieDetailURL(movieId) else {
            let APIError = NSError(domain: "MovieDB", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
            completion(nil, APIError)
            return
        }
        
        let searchRequest = URLRequest(url: searchURL)
        
        URLSession.shared.dataTask(with: searchRequest, completionHandler: { (data, response, error) in
            
            if let _ = error {
                let APIError = NSError(domain: "MovieDB", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
                OperationQueue.main.addOperation({
                    completion(nil, APIError)
                })
                return
            }
            
            guard let _ = response as? HTTPURLResponse,
                let data = data else {
                    let APIError = NSError(domain: "MovieDB", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
                    OperationQueue.main.addOperation({
                        completion(nil, APIError)
                    })
                    return
            }
            
            completion(data,nil)
            
            
        }) .resume()
    }
    
    func getCollectionDetails(_ collectionId: Int, completion : @escaping (_ result : Data?, _ error : NSError?) -> Void){
        
        guard let searchURL = collectionDetailURL(collectionId) else {
            let APIError = NSError(domain: "MovieDB", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
            completion(nil, APIError)
            return
        }
        
        let searchRequest = URLRequest(url: searchURL)
        
        URLSession.shared.dataTask(with: searchRequest, completionHandler: { (data, response, error) in
            
            if let _ = error {
                let APIError = NSError(domain: "MovieDB", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
                OperationQueue.main.addOperation({
                    completion(nil, APIError)
                })
                return
            }
            
            guard let _ = response as? HTTPURLResponse,
                let data = data else {
                    let APIError = NSError(domain: "MovieDB", code: 0, userInfo: [NSLocalizedFailureReasonErrorKey:"Unknown API response"])
                    OperationQueue.main.addOperation({
                        completion(nil, APIError)
                    })
                    return
            }
            
            completion(data,nil)
            
        }) .resume()
    }
    
}

extension NetworkManager {
    
    fileprivate func movieURLForNowPlaying() -> URL? {
        
        let URLString = RequestURLProvider.basemovieURL + "/now_playing?api_key=\(Credential.apiKey)"
        
        guard let url = URL(string:URLString) else {
            return nil
        }
        
        return url
    }
    
    fileprivate func movieDetailURL(_ movieId:Int) -> URL? {
        
        let URLString = RequestURLProvider.basemovieURL + "/\(movieId)?api_key=\(Credential.apiKey)"
        
        guard let url = URL(string:URLString) else {
            return nil
        }
        
        return url
    }
    
    fileprivate func collectionDetailURL(_ collectionId:Int) -> URL? {
        
        let URLString = RequestURLProvider.baseCollectionURL + "/\(collectionId)?api_key=\(Credential.apiKey)"
        
        guard let url = URL(string:URLString) else {
            return nil
        }
        
        return url
    }
}
