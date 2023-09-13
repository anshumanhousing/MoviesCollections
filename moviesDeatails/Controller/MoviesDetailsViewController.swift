//
//  MoviesDetailsViewController.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit
/// for this class Extension are added
class MoviesDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    ///Make MoviesList Observable
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
    var dataT: [MovieData] = []{
        willSet{
            self.moviesList = newValue
        }
    }
    
    var currentIndex: Int?
    var pageNo: Int = 1
    var totalPages: Int = 0
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var MoviesDetailsTableView: UITableView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        getMoviesListFromApi()
    }
    
    ///Fetch Api Data and store Array
    func getMoviesListFromApi(){
        let loader = alertLoader()
        let apiUrlString = JsonConstants.API_URL + String(describing: pageNo)
        DataGet.shared.getMovieData(fromUrl: apiUrlString) { apiData, pages in
            if let getApiData = apiData {
                DispatchQueue.main.async{
                    self.dataT = self.dataT + getApiData
                    self.totalPages = pages
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.stopLoader(loader: loader)
        }
    }
}


///Table View Things added in Extensions
