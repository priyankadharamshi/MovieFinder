//
//  MovieCell.swift
//  MovieFinder
//
//  Created by Priyanka on 10/06/18.
//  Copyright © 2018 Priyanka. All rights reserved.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    fileprivate var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        commonInit()
        
    }
    
    func setupCell(forMovie : Movie) {
        self.imageView.image = nil
        if let imageLink = forMovie.posterImagePath {
            updatePosterImage(urlString:imageLink)
        }
    }
}

// MARK: Image loading helper and setup methods
fileprivate extension MovieCell {
    
    func commonInit() {
        
        imageView = UIImageView()
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant : -10 ),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant : -10)
            ])
        
    }
    func updatePosterImage(urlString: String) {
        
        if let url = URL.init(string: urlString) {
            
            getDataFromUrl(url: url) { data, response, error in
                guard let data = data, error == nil else { return }
                DispatchQueue.main.async() {
                    self.imageView.image = UIImage(data: data)
                }
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
}


