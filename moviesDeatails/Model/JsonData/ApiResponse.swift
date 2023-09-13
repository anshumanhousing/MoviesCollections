//
//  ApiResponse.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import Foundation

///Get Method of api
struct Response: Decodable, Encodable{
    var dates: DatesValue?
    var page: Int?
    var results: [MovieData]
    var total_pages: Int?
    var total_results: Int?
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(page, forKey: .page)
        try container.encode(total_pages, forKey: .total_pages)
        try container.encode(total_results, forKey: .total_results)
    }
}
 
///required 
struct MovieData: Decodable, Equatable{
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var id: Int?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Float?
    var poster_path: String?
    var release_date: String?
    var title: String
    var video: Bool?
    var vote_average: Float?
    var vote_count: Int?
}

struct DatesValue: Decodable{
    var maximum: String?
    var minimum: String?
}
