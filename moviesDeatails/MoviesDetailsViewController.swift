//
//  MoviesDetailsViewController.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit

class MoviesDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var moviesList = [MovieData]()
    var currentIndex: Int?
    @IBOutlet weak var MoviesDetailsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MoviesDetailsTableView.dataSource = self
        MoviesDetailsTableView.delegate = self
        getMoviesListFromApi()
    }
    
    func getMoviesListFromApi(){
        let apiUrlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1"
        let apiUrl = URL(string: apiUrlString)
        let request = URLRequest(url: apiUrl!)
        let data = try? Data(contentsOf: apiUrl!)
        let apiResponnse = try? JSONDecoder().decode(Response.self, from: data!)
        self.moviesList = apiResponnse?.results ?? [MovieData]()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = MoviesDetailsTableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? MoviesDetailsTableViewCell
        
        cell?.movieTitle.text = "\(String(moviesList[indexPath.row].title))"
        cell?.movieOverview.text = "\(String(moviesList[indexPath.row].overview))"
        
        let urlString = String("https://image.tmdb.org/t/p/w500" + moviesList[indexPath.row].poster_path)
        let imageURL = URL(string: urlString)
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
        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.performSegue(withIdentifier: "movieDetailsSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "movieDetailsSegue" {
            let movieContent = segue.destination as? MoviesOverviewViewController
            movieContent?.movieDetail = moviesList[currentIndex!]
        }
    }


}
