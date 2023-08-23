//
//  HelperFile.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import Foundation
import UIKit


class Downloader{
    class func imageDownloader(fromUrl urlString: String) -> UIImage{
        let defaultImage = UIImage(systemName: "photo.artframe")!
        
        guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else {
            return defaultImage
        }
        
        guard let extractedImage = UIImage(data: data) else {
            return defaultImage
        }
        return extractedImage
    }
    
//    class func imageDownloaderUrlSession(fromurl urlString: String) -> UIImage{
//        let imageURL = URL(string: urlString)
//        var image: UIImage?
//        URLSession.shared.downloadTask(with: imageURL!){ (fileURL, URLResponse, error) in
//            guard error == nil else{
//                print(error?.localizedDescription)
//                return
//            }
//            let response = URLResponse as! HTTPURLResponse
//            guard response.statusCode == 200 else{
//                print(response.statusCode)
//                return
//            }
//            guard let url = fileURL , let imageContent = try? Data(contentsOf: url) else{
//                return
//            }
//            DispatchQueue.main.async {
//                let imag = UIImage(data: imageContent)
//                image = imag
//                
//            }
//            //image = UIImage(data: imageContent)
//        }.resume()
//        return image!
//    }
    
    
}
