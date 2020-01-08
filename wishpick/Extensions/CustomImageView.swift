//
//  CustomImageView.swift
//  wishpick
//
//  Created by Ryan Nguyen on 1/8/20.
//  Copyright © 2020 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {
    
    var lastURLUseToLoadImage: String?
    
    func loadImage(urlString: String) {
        
        lastURLUseToLoadImage = urlString
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed to post image", err)
            }
            
            // Ensures that the loaded image is not the same
            if url.absoluteString != self.lastURLUseToLoadImage { return }
            
            guard let imageData = data else { return }
            let photoImage = UIImage(data: imageData)
            DispatchQueue.main.async {
                self.image = photoImage
            }
        }.resume()
    }
}
