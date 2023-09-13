//
//  ApiResponse.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import Foundation


struct Response: Decodable{
    var dates: DatesValue
    var page: Int
    var results: [MovieData]
    var total_pages: Int
    var total_results: Int
}
 
struct MovieData: Decodable, Equatable{
    var adult: Bool
    var backdrop_path: String
    var genre_ids: [Int]
    var id: Int
    var original_language: String
    var original_title: String
    var overview: String
    var popularity: Float
    var poster_path: String
    var release_date: String
    var title: String
    var video: Bool
    var vote_average: Float
    var vote_count: Int
}

struct DatesValue: Decodable{
    var maximum: String
    var minimum: String
}

struct RequiredDetail: Decodable{
    var title: String
    var overview: String
    var popularity: Double
    var release_date: String
    var vote_average: Double
    var poster_path: String
}
struct Result: Decodable{
    var results: [RequiredDetail]
}
