//
//  MoviesDetailsViewController.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit

class MoviesDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let c = ["King", "Queen", "Rook", "Bishop", "Knight", "Pawn","King", "Queen", "Rook", "Bishop", "Knight", "Pawn","King", "Queen", "Rook", "Bishop", "Knight", "Pawn","King", "Queen", "Rook", "Bishop", "Knight", "Pawn"]
    var moviesList = [MovieData]()
    var currentIndex: Int?
    @IBOutlet weak var MoviesDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MoviesDetailsTableView.dataSource = self
        MoviesDetailsTableView.delegate = self
        getMoviesListFromApi()
        print(moviesList.count)
    }
    
    func getMoviesListFromApi(){
        let apiUrlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1"
        let apiUrl = URL(string: apiUrlString)
        let request = URLRequest(url: apiUrl!)
        let data = try? Data(contentsOf: apiUrl!)
        let apiResponnse = try? JSONDecoder().decode(Response.self, from: data!)
        self.moviesList = apiResponnse?.results ?? [MovieData]()
        
//        URLSession.shared.dataTask(with: request) { (data,response,error) in
//            guard error == nil, data != nil else {
//                print(error?.localizedDescription ?? "Error while fetching data")
//                return
//            }
//            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                print("Status Code not 200")
//                return
//            }
//            let apiResponse = try? JSONDecoder().decode(Response.self, from: data!)
////            DispatchQueue.main.async {
////                self.moviesList = apiResponse?.results ?? [MovieData]()
////            }
//            self.moviesList = apiResponse?.results ?? [MovieData]()
//            print(self.moviesList.count)
//
//        }.resume()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return c.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MoviesDetailsTableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? MoviesDetailsTableViewCell
        
        let imageURL = URL(string: "https://image.tmdb.org/t/p/w500//6oH378KUfCEitzJkm07r97L0RsZ.jpg")
        //cell?.movieImage.image = Downloader.imageDownloaderUrlSession(fromurl: "https://image.tmdb.org/t/p/w500//6oH378KUfCEitzJkm07r97L0RsZ.jpg")
        URLSession.shared.downloadTask(with: imageURL!){ (fileURL, URLResponse, error) in
            guard error == nil else{
                print(error!.localizedDescription)
                return
            }
            let response = URLResponse as! HTTPURLResponse
            guard response.statusCode == 200 else{
                print(response.statusCode)
                return
            }
            guard let url = fileURL , let imageContent = try? Data(contentsOf: url) else{
                return
            }
            DispatchQueue.main.async {
                cell?.movieImage.image = UIImage(data: imageContent)
                cell?.movieImage.layer.cornerRadius = 15
            }
        }.resume()
        
        cell?.movieTitle.text = c[indexPath.row]
        cell?.movieOverview.text = "On the brink of losing her childhood home, Maddie discovers an intriguing job listing: wealthy helicopter parents looking for someone to “date” their introverted 19-year-old son, Percy, before he leaves for college. To her surprise, Maddie soon discovers the awkward Percy is no sure thing."
        
//        let urlString = String("https://image.tmdb.org/t/p/w500" + moviesList[indexPath.row].poster_path)
//        cell?.movieImage.image = Downloader.imageDownloader(fromUrl: urlString)
//        cell?.movieTitle.text = "\(String(moviesList[indexPath.row].title))"
//        cell?.movieOverview.text = "\(String(moviesList[indexPath.row].overview))"
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.performSegue(withIdentifier: "movieDetailsSegue", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "currentIndex" {
            let movieContent = segue.destination as? MoviesOverviewViewController
            movieContent?.movieDetail = moviesList[currentIndex!]
        }
    }


}
