//
//  NetworkManeger.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 03/09/23.
//
import Foundation
import UIKit
import Alamofire

 class Url{
     static let shared = Url()
     private init(){}
     func getURL(urlString: String) -> URL?{
         let url = URL(string: urlString)
         return url
     }
 }

 class NetworkHandler{
     static let shared = NetworkHandler()
     private init(){}
     func getUrlData(url: URL, completion: @escaping ((_ data: Data?) -> ()?)){
         Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).response{ data in
             do {
                 guard let data = data.data else {
                     return
                 }
                 completion(data)
             }
         }
     }
 }

 class Decoder{
     static let shared = Decoder()
     private init(){}
     
     func apiDecoder<T: Codable>(type: T.Type, data: Data) -> T?{
         let apiData = try? JSONDecoder().decode(T.self, from: data)
         return apiData
     }
 }



