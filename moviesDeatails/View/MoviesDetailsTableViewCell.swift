//
//  MoviesDetailsTableViewCell.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit
import Contacts

class MoviesDetailsTableViewCell: UITableViewCell{
    
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    
    ///set all details automatically 
    var movieDeatails: MovieData?{
        willSet{
            movieTitle.text = newValue!.title
            movieOverview.text = newValue!.overview
            guard let pst_path = newValue?.poster_path else{
                return
            }
            let urlString = String(JsonConstants.POSTER_HEADER + pst_path)
            //movieImage.image = UIImage(named: Image.SYSTEM_IMAGE_NAME) ///placeholderImage
            let loader = activity.getActivityIndicator()
            loader.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))
            Downloader.shared.getImage(fromUrl: urlString) { image in
                if let imageObj = image{
                    DispatchQueue.main.async{
                        self.movieImage.image = imageObj
                        loader.stopAnimating()
                    }
                }
            }
            
           // movieImage.getImage(fromUrl: urlString)
            movieImage.layer.cornerRadius = CGFloat(Image.CORNER_RADIUS)
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
    
    /// To avoid content Overalap
    override func prepareForReuse() {
        super.prepareForReuse()
        isHidden = false
        isSelected = false
        isHighlighted = false
    }
    
    /*
    func setUp(data: MovieData?, isLastItem: Bool = false){
//        if isLastItem {
//            clearAll()
//        }
        if let data = data{
            movieTitle.text = data.title
            movieOverview.text = data.overview
            let urlString = String(JsonConstants.POSTER_HEADER + data.poster_path)
            movieImage.image = UIImage(named: Image.SYSTEM_IMAGE_NAME) ///placeholder
            Downloader.shared.getImage(fromUrl: urlString) { image in
                if let imageObj = image{
                    DispatchQueue.main.async {
                        self.movieImage.image = imageObj
                    }
                }
            }
        }
        /*
        movieTitle.text = data?.title
        movieOverview.text = data?.overview
        let urlString = String(JsonConstants.POSTER_HEADER + data!.poster_path)
        movieImage.image = UIImage(named: Image.SYSTEM_IMAGE_NAME)
        Downloader.shared.getImage(fromUrl: urlString) { image in
            if let imageObj = image{
                DispatchQueue.main.async {
                    self.movieImage.image = imageObj
                }
            }
        }
         */
    }
    
//    func clearAll(){
//        movieImage.image = nil
//        movieTitle.text = nil
//        movieOverview.text = nil
//    }
    */

}
