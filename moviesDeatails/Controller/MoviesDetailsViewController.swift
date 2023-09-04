//
//  MoviesDetailsViewController.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 22/08/23.
//

import UIKit
/// for this class Extension are added
class MoviesDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    /*
    let moviesDataLocal: MoviesHandler
    let moviesDataApi: MoviesHandler
    init(moviesDataLocal: MoviesHandler = LocalMoviesData(), moviesDataApi: MoviesHandler = MovieDataBase()) {
        self.moviesDataLocal = moviesDataLocal
        self.moviesDataApi = moviesDataApi
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    */
    
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
        if apiUrlString.correctUrl(){
            MovieDataBase.shared.getMoviesList(fromUrl: apiUrlString) { apiData, pages in
                if let getApiData = apiData {
                    DispatchQueue.main.async{
                        self.dataT = self.dataT + getApiData
                        self.totalPages = pages
                    }
                }
            }
        }else{
            LocalMoviesData.shared.getMoviesList(fromUrl: apiUrlString) { apiData, pages in
                if let getApiData = apiData {
                    DispatchQueue.main.async{
                        self.dataT = self.dataT + getApiData
                        self.totalPages = pages
                    }
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            self.stopLoader(loader: loader)
        }
        
    }
    
  /*
    @IBAction func nextButton(_ sender: Any) {
        if pageNo < totalPages {
            pageNo = pageNo + 1
            getMoviesListFromApi()
            //moviesList = dataT
            //MoviesDetailsTableView.reloadData()
        }
        else {
            showAlert(withtTitle: Alert.TITLE, andMessage: Alert.MESSAGE)
        }
    }
  */
}


///Table View Things added in Extensions
