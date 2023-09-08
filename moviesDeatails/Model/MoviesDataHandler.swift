//
//  MoviesDataHandler.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 04/09/23.
//

import Foundation
import UIKit

protocol MoviesHandler{
    func getMoviesList(fromUrl urlString: String, completion: ((_ apiData: [MovieData]?, _ totalPages: Int) -> ())?)
}

class MovieDataBase: MoviesHandler{
     func getMoviesList(fromUrl urlString: String, completion: ((_ apiData: [MovieData]?, _ totalPages: Int) -> ())?){
         guard let url = Url.shared.getURL(urlString: urlString) else{
             return
         }
         var data: Data?
         NetworkHandler.shared.getUrlData(url: url) { data1 in
             data = data1
             let jsonData = Decoder.shared.apiDecoder(type: Response.self ,data: data!)
             let movieData = jsonData?.results as [MovieData]?
             let t: Int = jsonData?.total_pages ?? 0
             completion?(movieData, t)
         }
     }
 }


class LocalMoviesData: MoviesHandler{
    func getMoviesList(fromUrl urlString: String, completion: (([MovieData]?, Int) -> ())?) {
        guard let url = Bundle.main.url(forResource: "Local", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let model = Decoder.shared.apiDecoder(type: Response.self ,data: data),
              let movieData = model.results as [MovieData]? else{
            return
        }
        completion?(movieData, 1)
    }
}

class Movie{
    let moviesHandler: MoviesHandler
    init(moviesHandler: MoviesHandler) {
        self.moviesHandler = moviesHandler
    }
    func getMovie(fromUrl urlString: String, completion: (([MovieData]?, Int) -> ())?){
        moviesHandler.getMoviesList(fromUrl: urlString) { apiData, totalPages in
            completion?(apiData,totalPages)
        }
    }
}


class DataGet{
    static let shared = DataGet()
    private init() {
    }
    func getMovieData(fromUrl urlString: String, completion: (([MovieData]?, Int) -> ())?){
        if urlString.correctUrl(){
            Movie(moviesHandler: MovieDataBase()).getMovie(fromUrl: urlString) {apiData, totalPages in
                completion?(apiData,totalPages)
            }
        }else{
            Movie(moviesHandler: LocalMoviesData()).getMovie(fromUrl: urlString) {apiData, totalPages in
                completion?(apiData,totalPages)
            }
        }
    }
}
