//
//  BaseCollectionFlowLayout.swift
//  FlickrSearch
//
//  Created by Priyanka  on 10/06/18.
//  Copyright © 2018 Richard Turton. All rights reserved.
//

import Foundation
import UIKit

class BaseCollectionFlowLayout : UICollectionViewFlowLayout {
  
    convenience init(scrollDirection: UICollectionViewScrollDirection, itemSize: CGSize) {
        self.init()
        self.scrollDirection = scrollDirection
        self.itemSize = itemSize
    }
}
