//
//  Constant.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 25/08/23.
//

import Foundation


struct JsonConstants{
    static let API_URL: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page="
    static let POSTER_HEADER: String = "https://image.tmdb.org/t/p/w500"
    let TOTAL_PAGES: Int?
}

struct Identifiers{
    static let CELL_IDENTIFIER: String = "cellId"
    static let MOVIE_DETAIL_SEGUE: String = "movieDetailsSegue"
}

struct Alert{
    static let TITLE: String = "Alert"
    static let MESSAGE: String = "No more Movies Left"
}

struct Button{
    static let TITLE: String = "Back"
}

struct Image{
    static let SYSTEM_IMAGE_NAME: String = "photo"
    static let CORNER_RADIUS: Int = 15
}
