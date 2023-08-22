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
        let defaultImage = UIImage(systemName: "person.fill.xmark")!
        
        guard let url = URL(string: urlString), let data = try? Data(contentsOf: url) else {
            return defaultImage
        }
        
        guard let extractedImage = UIImage(data: data) else {
            return defaultImage
        }
        return extractedImage
    }
}
