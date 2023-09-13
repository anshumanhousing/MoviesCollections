//
//  MoviesOverviewViewController.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit
import SDWebImage

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
        rating.text = Interfaces.rating
        popularity.text = Interfaces.popularity
        overview.text = Interfaces.overview
        releaseDate.text = Interfaces.releaseDate
    }
    
    ///Set all details Ui
    func setAllDetails(){
        moviePoster.layer.cornerRadius = CGFloat(Image.CORNER_RADIUS)
        movieTitle.text = movieDetail?.title
        moviePopularity.text = "\(movieDetail?.popularity ?? 1100.006)"
        movieRating.text = "\(movieDetail?.vote_average ?? 5.0)"
        movieReleaseDate.text = movieDetail?.release_date
        overViewTextField.text = movieDetail?.overview
        guard let pst_path = movieDetail?.poster_path else{
            return
        }
        let urlString = String(JsonConstants.POSTER_HEADER + pst_path)
        moviePoster.getImage(fromUrl: urlString)
    }
    
    ///Navigation topBar Back Button
    func backButton(){
        let backButton = UIBarButtonItem()
        backButton.title = Button.TITLE
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }

}

