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
    
    class func apiData(fromUrl urlString: String) -> [MovieData] {
        var moviesList = [MovieData]()
        let apiUrl = URL(string: urlString)
        let request = URLRequest(url: apiUrl!)
        let data = try? Data(contentsOf: apiUrl!)
        let apiResponnse = try? JSONDecoder().decode(Response.self, from: data!)
        moviesList = apiResponnse?.results ?? [MovieData]()
        return moviesList
    }
}

extension UIViewController{
    func showAlert(withtTitle alert: String, andMessage message: String, actionTitle  :String = "Cancel") {
        let alert = UIAlertController(title: alert, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(action)
        present(alert, animated: true)
    }
}
