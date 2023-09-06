//
//  DataDownload.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 26/08/23.
//

import Foundation

import UIKit
import Alamofire

///Download Api data From Network
class JsonDownloader{
    
    ///Make Class Singleton
    static let shared = JsonDownloader()
    private init(){
    }
    
    /// Get Data Using URLSession
    func apiData(fromUrl urlString: String, completion: ((_ apiData: [MovieData]?, _ totalPages: Int, _ error: String?) -> ())?){
           guard let url = URL(string: urlString) else {
              completion?(nil, 0, urlString)
              return
          }
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else {
                return
            }
            do {
                guard let apiData = try? JSONDecoder().decode(Response.self, from: data) else{
                    return
                }
                if let movieData = apiData.results as [MovieData]?{
                    guard let totalpage = apiData.total_pages else{
                        return
                    }
                    completion!(movieData, totalpage, nil)
                }
            }
        }.resume()
     }
    
    /// Get Data Using AlamoFire
    func apiDataFromAF(fromUrl urlString: String, completion: ((_ apiData: [MovieData]?, _ totalPages: Int, _ error: String?) -> ())?){
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response{ data in
            guard let data = data.data else {
                return
            }
            do {
                guard let apiData = try? JSONDecoder().decode(Response.self, from: data) else{
                    return
                }
                if let movieData = apiData.results as [MovieData]?{
                    guard let totalpage = apiData.total_pages else{
                        return
                    }
                    completion!(movieData, totalpage, nil)
                }
            }
        }
    }
}
