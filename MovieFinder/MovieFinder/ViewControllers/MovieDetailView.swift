//
//  MovieDetailView.swift
//  MovieFinder
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Richard Turton. All rights reserved.
//

import UIKit

class MovieDetailView: UIView {

    @IBOutlet weak var contentView : UIView!
    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var budgetLabel: UILabel!
    
    @IBOutlet weak var overviewTextView: UITextView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    convenience init(movieDetail : Movie) {
        self.init()
        commonInit()
        self.movieDetail = movieDetail
        updateDetail(movie: movieDetail)
        
    }

    private var movieDetail : Movie?
    
    func updateDetail(movie : Movie?) {

        if let movie = movie {
            setUpViewDetails(forMovie: movie)
        }
    }
}

 extension MovieDetailView {
    
    fileprivate func commonInit() {
    
        Bundle.main.loadNibNamed("MovieDetailView", owner:self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth , .flexibleHeight]
    
    }
    fileprivate func setUpViewDetails(forMovie : Movie) {
        
        DispatchQueue.main.async {
            
            // Get poster image
            self.moviePoster.image = nil
            self.budgetLabel.text = "Budget: $" + String.init(forMovie.budget ?? 0)
            self.overviewTextView.text = forMovie.overview
            if let path = forMovie.posterImagePath {
                self.updatePosterImage(urlString: path)
            }
            
        }
    }
    

}

// MARK: Update poster image
 extension MovieDetailView {
    
    fileprivate func updatePosterImage(urlString: String) {
        
        if let url = URL.init(string: urlString) {
            
            getDataFromUrl(url: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.moviePoster.image = UIImage(data: data)
                }
            }
        }
    }
    
    fileprivate func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
}
