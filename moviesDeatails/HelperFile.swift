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
        let apiUrlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1"
        let apiUrl = URL(string: apiUrlString)
        let request = URLRequest(url: apiUrl!)
        let data = try? Data(contentsOf: apiUrl!)
        let apiResponnse = try? JSONDecoder().decode(Response.self, from: data!)
        moviesList = apiResponnse?.results ?? [MovieData]()
        return moviesList
    }
}
