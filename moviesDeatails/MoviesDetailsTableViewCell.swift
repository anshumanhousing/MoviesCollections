//
//  MoviesDetailsTableViewCell.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit

class MoviesDetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    
    var movieDeatails: MovieData?{
        willSet{
            movieImage.image = Downloader.imageDownloader(fromUrl: "https://image.tmdb.org/t/p/w500" + newValue!.poster_path)
            movieTitle.text = newValue!.title
            movieOverview.text = newValue!.overview
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
