//
//  MoviesOverviewViewController.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit

class MoviesOverviewViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var moviePopularity: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var movieDetail: MovieData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton()
        setAllDetails()
    }
    
    func setAllDetails(){
        moviePoster.layer.cornerRadius = 15
        movieTitle.text = "Elemental"
        moviePoster.image = Downloader.imageDownloader(fromUrl: "https://image.tmdb.org/t/p/w500//6oH378KUfCEitzJkm07r97L0RsZ.jpg")
        moviePopularity.text = "3816.744"
        movieRating.text = "7.8"
        movieReleaseDate.text = "2023-06-14"
        movieOverview.text = "In a city where fire, water, land and air residents live together, a fiery young woman and a go-with-the-flow guy will discover something elemental: how much they have in common."
    }
    func setAllDetail(){
        moviePoster.layer.cornerRadius = 15
        movieTitle.text = movieDetail?.title
        moviePoster.image = Downloader.imageDownloader(fromUrl: "https://image.tmdb.org/t/p/w500" + movieDetail!.poster_path)
        moviePopularity.text = String(describing: movieDetail?.popularity)
        movieRating.text = String(describing: movieDetail?.vote_average)
        movieReleaseDate.text = movieDetail?.release_date
        movieOverview.text = movieDetail?.overview
    }
    
    func backButton(){
        movieOverview.text = " On the brink of losing her childhood home, Maddie discovers an intriguing job listing: wealthy helicopter parents looking for someone to “date” their introverted 19-year-old son, Percy, before he leaves for college."
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}
