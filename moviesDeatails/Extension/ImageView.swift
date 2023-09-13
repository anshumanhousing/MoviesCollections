//
//  ImageView.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 13/09/23.
//

import Foundation
import UIKit
import SDWebImage


extension UIImageView{
    
    class ImageStore: NSObject {
        static let cache = NSCache<NSString, UIImage>()
    }
    ///Get image
    func getImage(fromUrl urlString: String) {
        /// If image already in Cache
        if let cacheImage = ImageStore.cache.object(forKey: urlString as NSString) {
            self.image = cacheImage
        }/// If image not in Cache
        else{
            sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
            sd_imageIndicator?.startAnimatingIndicator()
            let placeHolder = UIImage(named: Image.SYSTEM_IMAGE_NAME) ///placeholderImage
            guard let imageURL = Url.shared.getURL(urlString: urlString) else{
                return
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                self.sd_setImage(with: imageURL, placeholderImage: placeHolder)
                guard let image = self.image else{
                    return
                }
                ImageStore.cache.setObject(image, forKey: urlString as NSString)
            }
            //////
            ///
            ///
            ///
            ///
            ///
            ///
        }
    }
}
