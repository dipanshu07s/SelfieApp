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
    
    private lazy var filteredImages: [CIImage] = {
        guard let image = self.photo else { return [] }
        let filteredImageBuilder = FilteredImageBuilder(image: image)
        return filteredImageBuilder.imageWithDefaultFilters()
    }()
    
    let eaglContext = EAGLContext(api: .openGLES3)
    
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
        
        let image = filteredImages[indexPath.row]
        
        cell.eaglContext = eaglContext
        cell.image = image
        
        return cell
    }
    
    
}
