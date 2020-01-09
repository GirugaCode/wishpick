//
//  CustomImageView.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/8/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

/// Holds all the cached images in a dictionary
var imageCache = [String: UIImage]()

class CustomImageView: UIImageView {
    
    var lastURLUseToLoadImage: String?
    
    /**
     Loads images with URL Sessions to be availible to image views

     - Parameters:
        - urlString: The url string of the image to load in
     */

    func loadImage(urlString: String) {
        
        lastURLUseToLoadImage = urlString
        
        // Checks if the image is in the cached area to optimize network
        if let cachedImage = imageCache[urlString] {
            self.image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to post image", err)
            }
            
            // Ensures that the loaded image is not the same
            if url.absoluteString != self.lastURLUseToLoadImage { return }
            
            guard let imageData = data else { return }
            
            let photoImage = UIImage(data: imageData)
            
            // Adds the image to cached dictionary
            imageCache[url.absoluteString] = photoImage
            
            DispatchQueue.main.async {
                self.image = photoImage
            }
            
        }.resume()
    }
}
