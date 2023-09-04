//
//  ApiResponse.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import Foundation

///Get Method of api
struct Response: Decodable, Encodable{
    var dates: DatesValue
    var page: Int
    var results: [MovieData]
    var total_pages: Int
    var total_results: Int
    /*
    enum CodingKeys: String, CodingKey{
        case dates
        case page
        case results
        case total_pages
        case total_results
    }
     */
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        //try container.encode([DatesValue], forKey: .dates)
        try container.encode(page, forKey: .page)
        //try container.encode([MovieData].self, forKey: .results)
        try container.encode(total_pages, forKey: .total_pages)
        try container.encode(total_results, forKey: .total_results)
    }
}
 
///required 
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
    /*
    enum CodingKeys: String, CodingKey{
        case adult
        case backdrop_path
        case genre_ids
        case id
        case original_language
        case original_title
        case overview
        case popularity
        case poster_path
        case release_date
        case title
        case video
        case vote_average
        case vote_count
    }
     */
}

struct DatesValue: Decodable, Encodable{
    var maximum: String
    var minimum: String
    /*
    enum CodingKeys: String, CodingKey{
        case maximum
        case minimum
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(maximum, forKey: .maximum)
        try container.encode(minimum, forKey: .minimum)
    }
     */
}
