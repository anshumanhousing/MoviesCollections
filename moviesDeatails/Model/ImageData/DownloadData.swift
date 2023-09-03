//
//  HelperFile.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import Foundation
import UIKit

/// Download Image from Network
class Downloader{
    
    ///Make Class Singleton
    static let shared = Downloader()
    private init(){}
    
    var task: URLSessionDataTask! /// global task
    
    ///Cache the Image Data on Local
    class ImageStore: NSObject {
        static let cache = NSCache<NSString, UIImage>()
    }
    
    ///Get image
    func getImage(fromUrl urlString: String, completion: ((_ image: UIImage?) -> ())?) {
        
        /// Cancle all previous task to avoid image overlap
        if let task = task{
            task.cancel()
        }
        /// If image already in Cache 
        if let image = ImageStore.cache.object(forKey: urlString as NSString) {
            completion?(image)
        }/// If image not in Cache
        else{
            guard let url = URL(string: urlString) else {
                completion?(nil)
                return
            }
            URLSession.shared.dataTask(with: url) { (data, response,error) in
                if let error = error {
                    print("\(error)")
                    completion?(nil)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    print("Status code not 200")
                    completion?(nil)
                    return
                }
                if let data = data, let image = UIImage(data: data) {
                    ImageStore.cache.setObject(image, forKey: urlString as NSString)
                    completion?(image)
                    return
                }
                completion?(nil)
            }.resume()
        }
    }
    
}

