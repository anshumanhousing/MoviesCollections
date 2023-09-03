//
//  NetworkManeger.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 03/09/23.
//


import Foundation
import UIKit

 
 class Url{
     func getURL(urlString: String) -> URL?{
         let url = URL(string: urlString)
         return url
     }
 }

 class NetworkHandler{
     func getUrlData(url: URL, completion: @escaping ((_ data: Data?) -> ()?)){
         URLSession.shared.dataTask(with: url){ (data, response, error) in
             if let error = error {
                 print("\(error)")
                 //completion(nil)
                 return
             }
             guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                 print("Status code not 200")
                 //completion(nil)
                 return
             }
             if let data = data {
                 DispatchQueue.main.async {
                     completion(data)
                 }
             }
         }.resume()
     }
 }

/*
 class Decoder{
     func apiDecoder<T: Codable>(data: Data, resultType: T.Type) -> T?{
         let apiData = try? JSONDecoder().decode(resultType.self, from: data)
         return apiData
     }
 }
 */
 class Decoder{
     func apiDecoder(data: Data) -> Response?{
         let apiData = try? JSONDecoder().decode(Response.self, from: data)
         return apiData
     }
 }


 class MovieDataBase{
     let urlhandler: Url
     let jsonHandler: NetworkHandler
     let jsonDecoder: Decoder
     init(urlhandler: Url, jsonHandler: NetworkHandler, jsonDecoder: Decoder) {
         self.urlhandler = urlhandler
         self.jsonHandler = jsonHandler
         self.jsonDecoder = jsonDecoder
     }
     func getMoviesList(fromUrl urlString: String, completion: ((_ apiData: [MovieData]?, _ totalPages: Int) -> ())?){
         guard let url = urlhandler.getURL(urlString: urlString) else{
             return
         }
         var data: Data?
         jsonHandler.getUrlData(url: url) { data1 in
             data = data1
             let jsonData = self.jsonDecoder.apiDecoder(data: data!)
             let movieData = jsonData?.results as [MovieData]?
             let t: Int = jsonData?.total_pages ?? 0
             completion!(movieData, t)
         }
         /*
         guard let jsonData = jsonDecoder.apiDecoder(data: data!) else{
             return
         }
         guard let movieData = jsonData.results as [MovieData]? else{
             return
         }
         completion!(movieData, jsonData.total_pages)
          */
     }
 }


















 /*
class Url{
    class func getURL(urlString: String, completion: ((_ url: URL) -> ()?)){
        guard let url = URL(string: urlString) else {
            return
        }
        completion(url)
        return
    }
}

class NetworkHandler{
    class func getUrlData(urlString: String, completion: @escaping((_ data: Data) -> ()?)){
        var url: URL?
        Url.getURL(urlString: urlString) { urL in
            url = urL
        }
        URLSession.shared.dataTask(with: url!){ (data, response, error) in
            if let error = error {
                print("\(error)")
                //completion(nil)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Status code not 200")
                //completion(nil)
                return
            }
            if let data = data {
                completion(data)
                return
            }
            //completion(nil)
        }.resume()
    }
}

//pass moviedata
//class Decoder{
//    func apiDecoder<T: Codable>(data: Data, resultType: T.Type) -> T?{
//        let apiData = try? JSONDecoder().decode(resultType.self, from: data)
//        return apiData
//    }
//}
class Decoder{
    
    class func apiDecoder(urlString: String) -> Response?{
        var data: Data?
        NetworkHandler.getUrlData(urlString: urlString) { data1 in
            DispatchQueue.main.async {
                data = data1
            }
        }
        //print(data)
        let apiData = try? JSONDecoder().decode(Response.self, from: data!)
        return apiData
    }
}
/*
class DataBase{
    func getDataBase(data: Data, completion: @escaping((_ movieData: [T]?) -> ()?)){
        guard let dataBase = data.resul else{
            return
        }
    }
}
*/


class MovieDataBase{
    class func getMoviesList(fromUrl urlString: String, completion: ((_ apiData: [MovieData]?, _ totalPages: Int) -> ())?){
        guard let jsonData = Decoder.apiDecoder(urlString: urlString) else{
            return
        }
        guard let movieData = jsonData.results as [MovieData]? else{
            return
        }
        completion!(movieData, jsonData.total_pages)
    }
}

  */




