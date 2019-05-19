//
//  PhotoFilterController.swift
//  ImageViewer
//
//  Created by Dipanshu Sehrawat on 19/05/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

class PhotoFilterController: UIViewController {
    
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    private lazy var filteredImages: [UIImage] = {
        guard let image = self.photo else { return [] }
        let filteredImageBuilder = FilteredImageBuilder(image: image)
        return filteredImageBuilder.imageWithDefaultFilters()
    }()
    
    var photo: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImageView.image = photo
        filterCollectionView.dataSource = self
    }

}

extension PhotoFilterController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilteredImageCell.reuseIdentifier, for: indexPath) as! FilteredImageCell
        
        cell.imageView.image = filteredImages[indexPath.row]
        
        return cell
    }
    
    
}
