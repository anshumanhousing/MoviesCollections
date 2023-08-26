//
//  Constant.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 25/08/23.
//

import Foundation


struct JsonConstants{
    static let apiUrl: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page="
    static let posterHeader: String = "https://image.tmdb.org/t/p/w500"
}

struct Identifiers{
    static let cell: String = "cellId"
    static let movieDetailsPageSegue: String = "movieDetailsSegue"
}

struct Alert{
    static let title: String = "Alert"
    static let message: String = "No more Movies Left"
}

struct Button{
    static let title: String = "Back"
}

struct Image{
    static let cornerRadius: Int = 15
}
