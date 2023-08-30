//
//  HelperFile.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import Foundation
import UIKit


class Downloader{
    static let shared = Downloader()
    private init(){}
    class ImageStore: NSObject {
        static let cache = NSCache<NSString, UIImage>()
    }
    func getImage(fromUrl urlString: String, completion: ((_ image: UIImage?) -> ())?) {
        if let image = ImageStore.cache.object(forKey: urlString as NSString) {
            DispatchQueue.main.async {
                completion?(image)
            }
        }else{
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
                guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
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


