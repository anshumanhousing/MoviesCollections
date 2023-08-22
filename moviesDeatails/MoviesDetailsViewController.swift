//
//  MoviesDetailsViewController.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit

class MoviesDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var MoviesDetailsTableView: UITableView!
    
    var moviesList = [MovieData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getMoviesList()
        print(moviesList)
    }
    
    func getMoviesList(){
        let apiUrlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=38a73d59546aa378980a88b645f487fc&language=en-US&page=1"
        let apiUrl = URL(string: apiUrlString)
        let request = URLRequest(url: apiUrl!)
        
        URLSession.shared.dataTask(with: request) { (data,response,error) in
            guard error == nil, data != nil else {
                print(error?.localizedDescription ?? "Error while fetching data...")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Status Code not 200")
                return
            }
            let apiResponse = try? JSONDecoder().decode(Response.self, from: data!)
            self.moviesList = apiResponse?.results ?? [MovieData]()
            print(self.moviesList.count)
            //print(self.moviesList)
            
        }.resume()
        print(moviesList.count)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MoviesDetailsTableView.dequeueReusableCell(withIdentifier: "UserDetailCellID", for: indexPath) as? MoviesDetailsTableViewCell
        
        guard let cell = cell else {
            return cell!
        }
        
        
        
        let url = URL(string: moviesList[indexPath.row].poster_path)
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            let data = try? Data(contentsOf: url!)
            
            if let data = data {
                
                DispatchQueue.main.async {
                    cell.movieImage.image = UIImage(data: data)
                }
                
            }
        }.resume()
        cell.movieTitle.text = "Helo"

        cell.movieOverview.text = "JHK"
        return cell
    }


}
