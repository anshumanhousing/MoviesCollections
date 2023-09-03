//
//  ImageView.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 01/09/23.
//

import Foundation
import UIKit


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
            let loader = activity.getActivityIndicator()
            loader.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
            self.addSubview(loader)
            guard let url = URL(string: urlString) else {
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response,error) in
                if let error = error {
                    print("\(error)")
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Status code not 200")
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        ImageStore.cache.setObject(image, forKey: urlString as NSString)
                        self.image = image
                        loader.stopAnimating()
                    }
                    return
                }
            }.resume()
        }
    }
}
