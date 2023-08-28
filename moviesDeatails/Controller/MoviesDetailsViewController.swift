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
    var pageNo: Int = 1
    var totalPages: Int = 0
    @IBOutlet weak var MoviesDetailsTableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        MoviesDetailsTableView.dataSource = self
        MoviesDetailsTableView.delegate = self
        getMoviesListFromApi()
    }

    func getMoviesListFromApi(){
        let apiUrlString = JsonConstants.apiUrl + String(pageNo)
        JsonDownloader.apiData(fromUrl: apiUrlString) { apiData, pages, error  in
            if let getApiData = apiData {
                DispatchQueue.main.async {
                    self.moviesList = self.moviesList + getApiData
                    self.totalPages = pages
                    self.MoviesDetailsTableView.reloadData()
                }
            }
        }
    }

    @IBAction func nextButton(_ sender: Any) {
        if pageNo < totalPages {
            pageNo = pageNo + 1
            getMoviesListFromApi()
            MoviesDetailsTableView.reloadData()
        }
        else {
            showAlert(withtTitle: Alert.title, andMessage: Alert.message)
        }
    }
}



extension MoviesDetailsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MoviesDetailsTableView.dequeueReusableCell(withIdentifier: Identifiers.cell, for: indexPath ) as? MoviesDetailsTableViewCell
        cell?.movieDeatails = moviesList[indexPath.row]
        cell?.movieImage.layer.cornerRadius = CGFloat(Image.cornerRadius)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.performSegue(withIdentifier: Identifiers.movieDetailsPageSegue, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.movieDetailsPageSegue{
            let movieContent = segue.destination as? MoviesOverviewViewController
            movieContent?.movieDetail = moviesList[currentIndex!]
        }
    }
}
