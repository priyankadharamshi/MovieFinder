//
//  ViewController.swift
//  MovieFinder
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Priyanka . All rights reserved.
//

import UIKit

class GridViewController: UIViewController {

    var movieListController : BaseCollectionViewController?
    
    let movieViewModel = MovieViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Movie Finder"
        
        setUpCollectionViewController()
        movieListController?.didMove(toParentViewController: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        getMovies()
    }
}

extension GridViewController {
    
    fileprivate func setUpCollectionViewController() {
        
        let layout:BaseCollectionFlowLayout = BaseCollectionFlowLayout.init(scrollDirection: .vertical, itemSize: CGSize.init(width: 200, height: 200))
        
        let controller = BaseCollectionViewController.init(collectionViewLayout: layout)
        
        addChildViewController(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(controller.view)
        
        NSLayoutConstraint.activate([
            controller.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            controller.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            controller.view.topAnchor.constraint(equalTo: self.view.topAnchor),
            controller.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            ])
        
        movieListController = controller
        
    }
    fileprivate func getMovies() {
        
        movieViewModel.fetchNowPlayingList(completionBlock: successHandler, errorBlock: failureHandler)

        
    }
    
}

// MARK: Callbacks
extension GridViewController {
    
    // When data is fetched successfully
    private func successHandler ( movieList : [Movie]) -> Void {
        
        self.movieListController?.movies = movieList
        
    }
    
    // When there is an error in fetching places. Http response code unauthorized, Connectivity issue
    private func failureHandler(error : Error?) -> Void {
        
        var message = "Unknown error in retrieving data"
        
        if Reachability.isConnectedToNetwork() == false {
            message = "No internet connection found. Please try again later."
        }
        
        showAlert(title: "Movie Finder", message: message)
        
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
