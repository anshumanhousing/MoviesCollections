//
//  MoviesDetailsViewControllerExtension.swift
//  moviesDeatails
//
//  Created by Anshuman Bhargava on 01/09/23.
//

import Foundation
import UIKit

extension MoviesDetailsViewController{
    
    ///Total cells
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesList.count
    }
    
    ///deque a cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = MoviesDetailsTableView.dequeueReuseCell(withIdentifiers: Identifiers.CELL_IDENTIFIER, forIndexPath: indexPath) as? MoviesDetailsTableViewCell else{
            return UITableViewCell()
        }
        cell.movieDeatails = moviesList[indexPath.row]
        /*
        let cell1 : MoviesDetailsTableViewCell = MoviesDetailsTableView.dequeueReuseCell(forIndexPath: indexPath)
        cell1.setUp(data: moviesList[indexPath.row])
        cell1.movieImage.layer.cornerRadius = CGFloat(Image.CORNER_RADIUS)
        return cell1c
         
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
    
    ///pagination
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == moviesList.count - 1 , pageNo < totalPages , searchBar.text == "" {
            pageNo += 1
            getMoviesListFromApi()
        }
        if indexPath.row == moviesList.count - 1, pageNo >= totalPages{
            showAlert(withtTitle: Alert.TITLE, andMessage: Alert.MESSAGE)
        }
    }
    
    
    ///selected row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.currentIndex = indexPath.row
        self.performSegue(withIdentifier: Identifiers.MOVIE_DETAIL_SEGUE, sender: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    
    /// prepare for Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.MOVIE_DETAIL_SEGUE{
            let movieContent = segue.destination as? MoviesOverviewViewController
            movieContent?.movieDetail = moviesList[currentIndex!]
        }
    }
    
    ///Serach Movies in `Movies Data`
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            moviesList = dataT.filter{ $0.title.contains(searchText)}
        }
        else{
            moviesList = dataT
        }
    }
}

