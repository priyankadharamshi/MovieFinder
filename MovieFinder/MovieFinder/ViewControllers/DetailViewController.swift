//
//  DetailViewController.swift
//  MovieFinder
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var otherMovieCollectionViewController : BaseCollectionViewController?
    var movieDetail : Movie? 
    
    var detailViewHeightConstraint: NSLayoutConstraint!
    var movieDetailView : MovieDetailView?
    
    var movieViewModel = MovieViewModel()
    
    var collectionViewModel = CollectionViewModel()
    
    convenience init(movieDetail : Movie) {
        self.init()
        self.movieDetail = movieDetail
        self.title = movieDetail.title
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDetailView()
        
        setupCollectionView()
      
    }

    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        getMovieDetails()
        
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: Detail view setup and related callbacks

extension DetailViewController {
    
    fileprivate func setupDetailView() {
        
        if let detail = self.movieDetail{
            let detailView = MovieDetailView.init(movieDetail: detail)
            
            detailView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(detailView)
            detailViewHeightConstraint = detailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            
            NSLayoutConstraint.activate([
                detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                detailView.topAnchor.constraint(equalTo: view.topAnchor),
                detailViewHeightConstraint,
                ])
            
            movieDetailView = detailView
        }
    }
    
    private func getMovieDetails() {
        
        if let movieId = movieDetail?.movieId {
            
            movieViewModel.fetchMovieDetail(movieId, completionBlock: successHandler, errorBlock: failureHandler)
        }
    }
    
    // When data is fetched successfully
    private func successHandler ( movieList : [Movie]) -> Void {
        
        if let movie = movieList.first {
            
            self.movieDetailView?.updateDetail(movie: movie)
            
            if let collectionId = movie.belongsToCollection?.collectionId {
                
                DispatchQueue.main.async {
                    
                    //Get collection details, show bottom collection view
                    self.detailViewHeightConstraint.constant = -self.view.frame.size.height/3
                    self.getCollectionList(collectionId)
                }
                
            }
        }
        
    }
    
    // When there is an error in fetching places. Http response code unauthorized, Connectivity issue
    private func failureHandler(error : Error?) -> Void {
        
        var message = "Unknown error in retrieving data"
        
        if Reachability.isConnectedToNetwork() == false {
            message = "No internet connection found. Please try again later."
        }
        
        showAlert(title: "Movie Finder", message: message)
        
    }
    
}

// MARK: Collection view setup and related methods
extension DetailViewController {
    
    fileprivate func setupCollectionView() {
        
        let layout:BaseCollectionFlowLayout = BaseCollectionFlowLayout.init(scrollDirection: .horizontal, itemSize: CGSize.init(width: 200, height: 200))
        
        let controller = BaseCollectionViewController.init(collectionViewLayout: layout)
        controller.itemsPerRow = 3
        addChildViewController(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        
        if let detailView = self.movieDetailView {
            NSLayoutConstraint.activate([
                controller.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                controller.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                controller.view.topAnchor.constraint(equalTo: detailView.bottomAnchor),
                controller.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
                ])
        }
        controller.didMove(toParentViewController: self)
        otherMovieCollectionViewController = controller
        
    }
    
    fileprivate func getCollectionList(_ forCollectionId : Int ) {
        
        self.otherMovieCollectionViewController?.movies = []
        collectionViewModel.fetchCollectionDetail(forCollectionId, completionBlock: collectionSuccessHandler, errorBlock: collectionFailureHandler)

    }
  
    // When data is fetched successfully
    private func collectionSuccessHandler ( collection : Collection?) -> Void {
        
        if let collection = collection {
            
            DispatchQueue.main.async {
              
                self.otherMovieCollectionViewController?.movies = collection.movieParts
                
            }
        }
        
    }
    
    // When there is an error in fetching places. Http response code unauthorized, Connectivity issue
    private func collectionFailureHandler(error : Error?) -> Void {
        
        var message = "Unknown error in retrieving data"
        
        if Reachability.isConnectedToNetwork() == false {
            message = "No internet connection found. Please try again later."
        }
        
        showAlert(title: "Movie Finder", message: message)
        
    }
    

}
