//
//  MoviesDetailsViewController.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit

class MoviesDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var moviesList: [MovieData] = []{
        willSet{
            self.moviesList = newValue
        }
        didSet{
            if self.moviesList != oldValue{
                MoviesDetailsTableView.reloadData()
            }
        }
    }
    let maxCell = 7
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
        let apiUrlString = JsonConstants.API_URL + String(describing: pageNo)
        JsonDownloader.shared.apiData(fromUrl: apiUrlString) { apiData, pages, error  in
            if let getApiData = apiData {
                DispatchQueue.main.async {
                    self.moviesList = self.moviesList + getApiData
                    self.totalPages = pages
                    //self.MoviesDetailsTableView.reloadData()
                }
            }
        }
    }

    @IBAction func nextButton(_ sender: Any) {
        if pageNo < totalPages {
            pageNo = pageNo + 1
            getMoviesListFromApi()
            //MoviesDetailsTableView.reloadData()
        }
        else {
            showAlert(withtTitle: Alert.TITLE, andMessage: Alert.MESSAGE)
        }
    }
}



extension MoviesDetailsViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = MoviesDetailsTableView.dequeueReuseCell(forIndexPath: indexPath) as? MoviesDetailsTableViewCell else{
            return UITableViewCell()
        }
        cell.movieDeatails = moviesList[indexPath.row]
        /*
        let cell1 : MoviesDetailsTableViewCell = MoviesDetailsTableView.dequeueReuseCell(forIndexPath: indexPath)
        cell1.setUp(data: moviesList[indexPath.row])
        cell1.movieImage.layer.cornerRadius = CGFloat(Image.CORNER_RADIUS)
        return cell1
         
         guard let cell = MoviesDetailsTableView.dequeueReuseCell(forIndexPath: indexPath) as? MoviesDetailsTableViewCell else{
             return UITableViewCell()
         }
        if indexPath.row == maxCell-1 {
            cell.setUp(data: moviesList[indexPath.row])
        }
        else{
            cell.setUp(data: moviesList[indexPath.row])
        }
         */
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.performSegue(withIdentifier: Identifiers.MOVIE_DETAIL_SEGUE, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.MOVIE_DETAIL_SEGUE{
            let movieContent = segue.destination as? MoviesOverviewViewController
            movieContent?.movieDetail = moviesList[currentIndex!]
        }
    }
}
