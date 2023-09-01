//
//  MoviesOverviewViewController.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit

class MoviesOverviewViewController: UIViewController{
    
    ///Interfaces
    @IBOutlet weak var releaseDate: UILabel!
    @IBOutlet weak var overview: UILabel!
    @IBOutlet weak var popularity: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    
    ///Contents
    @IBOutlet weak var overViewTextField: UITextView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var moviePopularity: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieReleaseDate: UILabel!
    //@IBOutlet weak var movieOverview: UILabel!
    
    var movieDetail: MovieData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backButton()
        setInterface()
        setAllDetails()
    }
    
    ///Set Interfaces
    func setInterface(){
        rating.text = "⭐️  Rating"
        popularity.text = "♥️ Popularity"
        overview.text = "Overview"
        releaseDate.text = "Release Date"
    }
    
    ///Set all details Ui
    func setAllDetails(){
        movieTitle.text = movieDetail?.title
        moviePopularity.text = "\(movieDetail!.popularity)"
        movieRating.text = "\(movieDetail!.vote_average)"
        movieReleaseDate.text = movieDetail?.release_date
        overViewTextField.text = movieDetail?.overview
        let urlString = String(JsonConstants.POSTER_HEADER + movieDetail!.poster_path)
        moviePoster.getImage(fromUrl: urlString)
        moviePoster.layer.cornerRadius = CGFloat(Image.CORNER_RADIUS)
    }
    
    ///Navigation topBar Back Button
    func backButton(){
        let backButton = UIBarButtonItem()
        backButton.title = Button.TITLE
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}

