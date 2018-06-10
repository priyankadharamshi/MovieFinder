import UIKit

final class BaseCollectionViewController: UICollectionViewController {
    
    fileprivate let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    // MARK: - Properties
    fileprivate let reuseIdentifier = "MovieCell"
    fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    var movies : [Movie] = [] {
        didSet {
            
            showMovieList()
        }
    }
    
    var itemsPerRow: Int = 2
    
}

// MARK: - Life cycle
extension BaseCollectionViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = .white
        collectionView?.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.collectionView?.addSubview(activityIndicator)
        activityIndicator.frame = collectionView?.bounds ?? .zero
        activityIndicator.startAnimating()
        
    }
    
    func showMovieList() {
        
        DispatchQueue.main.async {
            self.activityIndicator.removeFromSuperview()
            self.collectionView?.reloadData()
        }
       
    }
    
}

// MARK: - UICollectionViewDataSource
extension BaseCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                                         for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        cell.backgroundColor = UIColor.white
        cell.setupCell(forMovie: movie)
        
        return cell
    }
}

extension BaseCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * CGFloat(itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / CGFloat(itemsPerRow)
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
}

// MARK: Collection view delegate
extension BaseCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let movieDetail = movies[indexPath.row]
        let detailVC = DetailViewController.init(movieDetail: movieDetail)
        self.navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
