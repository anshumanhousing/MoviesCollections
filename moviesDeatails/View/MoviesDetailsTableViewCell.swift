//
//  MoviesDetailsTableViewCell.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit
import Contacts

class MoviesDetailsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var movieDeatails: MovieData?{
        willSet{
            let urlString = String(JsonConstants.posterHeader + newValue!.poster_path)
            Downloader.image(fromUrl: urlString) { image, urlString in
                if let imageObj = image {
                    DispatchQueue.main.async {
                        self.movieImage.image = imageObj
                    }
                }
            }
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
