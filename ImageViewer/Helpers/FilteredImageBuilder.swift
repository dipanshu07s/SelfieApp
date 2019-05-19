//
//  FilteredImageBuilder.swift
//  ImageViewer
//
//  Created by Dipanshu Sehrawat on 19/05/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import CoreImage
import UIKit


class FilteredImageBuilder {
    private let image: UIImage
    
    init(image: UIImage) {
        self.image = image
    }
    
    func applyFilter(_ filter: CIFilter) -> UIImage? {
        guard let inputImage = image.ciImage ?? CIImage(image: self.image) else { return nil }
        
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        
        guard let outputImage = filter.outputImage else { return nil }
        
        return UIImage(ciImage: outputImage)
    }
    
    func image(withFilters filters: [CIFilter]) -> [UIImage] {
        return filters.compactMap({ applyFilter($0) })
    }
    
    func imageWithDefaultFilters() -> [UIImage] {
        return image(withFilters: PhotoFilter.defaultFilters)
    }
}
