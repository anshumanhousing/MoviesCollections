//
//  DataDownload.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 26/08/23.
//

import Foundation

import UIKit


class JsonDownloader{
    
    class func apiData(fromUrl urlString: String) -> [MovieData] {
        var moviesList = [MovieData]()
        let apiUrl = URL(string: urlString)
        let data = try? Data(contentsOf: apiUrl!)
        let apiResponnse = try? JSONDecoder().decode(Response.self, from: data!)
        moviesList = apiResponnse?.results ?? [MovieData]()
        return moviesList
    }
    
    class func apiData(fromUrl urlString: String, completion: ((_ apiData: [MovieData]?, _ totalPages: Int, _ error: String?) -> ())?) {
           guard let url = URL(string: urlString) else {
              completion?(nil, 0, urlString)
              return
          }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                guard let apiData = try?  JSONDecoder().decode(Response.self, from: data) else{
                    return
                }
                if let movieData = apiData.results as [MovieData]?{
                    completion!(movieData, apiData.total_pages, nil)
                }
            }
        }.resume()

     }
}
