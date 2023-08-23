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
        movieTitle.text = movieDetail?.title
        moviePoster.image = Downloader.imageDownloader(fromUrl: "https://image.tmdb.org/t/p/w500" + movieDetail!.poster_path)
        moviePopularity.text = "\(movieDetail!.popularity)"
        movieRating.text = "\(movieDetail!.vote_average)"
        movieReleaseDate.text = movieDetail?.release_date
        movieOverview.text = movieDetail?.overview
    }
    
    func backButton(){
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}

