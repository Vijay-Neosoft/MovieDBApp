//
//  MovieDetailsViewController.swift
//  MovieDB
//
//  Created by NeoSOFT on 01/03/23.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    // MARK: - Global Variables
    var movieSimilarViewModel = MovieSimilarViewModel()
    var moviedetailsViewModel = MoviedetailsViewModel()
    var moviecastViewModel = MovieCastViewModel()
    var moviereviewViewModel = MovieReviewViewModel()
    var isExpanded : Bool = false
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchregister()
    }
    // MARK: - function fetchregister
        func fetchregister(){
            tableView.register(UINib(nibName: Identifiers.MovieDetailsTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Identifiers.MovieDetailsTableViewCell.rawValue)
            tableView.register(UINib(nibName:Identifiers.MovieCastTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Identifiers.MovieCastTableViewCell.rawValue)
            tableView.register(UINib(nibName: Identifiers.MovieReviewTableViewCell.rawValue, bundle: nil), forCellReuseIdentifier: Identifiers.MovieReviewTableViewCell.rawValue)
        moviedetailsViewModel.movieDetails(movie_id: moviedetailsViewModel.movie_id ?? 0){
            self.tableView.reloadData()
        }
        moviecastViewModel.fetchMovieCast(movie_id: moviecastViewModel.movie_id ?? 0) {
            self.tableView.reloadData()
        }
        moviereviewViewModel.moviereviewDetails(movie_id: moviereviewViewModel.movie_id ?? 0) {
            self.tableView.reloadData()
        }
        moviereviewViewModel.moviereviewDetails(movie_id: movieSimilarViewModel.movie_id ?? 0) {
            self.tableView.reloadData()
        }
        movieSimilarViewModel.movieDetailsSimilar(movie_id: movieSimilarViewModel.movie_id ?? 0) {
            self.tableView.reloadData()
        }
    }
    
}
enum Identifiers:String{
    case MovieDetailsTableViewCell
    case MovieCastTableViewCell
    case MovieReviewTableViewCell
}
