//
//  HelperFile.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import Foundation
import UIKit


class Downloader{
    
    class func image(fromUrl urlString: String, completion: ((_ image: UIImage?, _ error: String?) -> ())?) {
           guard let url = URL(string: urlString) else {
              completion?(nil, nil)
              return
          }
          URLSession.shared.dataTask(with: url) { (data, response,error) in
             if let error = error {
                print("\(error)")
                completion?(nil, "\(error)")
                return
             }
             guard let httpResponse = response as? HTTPURLResponse,(200...299).contains(httpResponse.statusCode) else {
                completion?(nil, "httpResponse.statusCode")
                return
             }
             if let data = data, let image = UIImage(data: data) {
                completion?(image, "OK")
                return
             }
             completion?(nil, urlString)
          }.resume()
       }
}

