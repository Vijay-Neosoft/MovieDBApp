//
//  SeachMoviesViewController.swift
//  MovieDB
//
//  Created by NeoSOFT on 15/03/23.
//

import UIKit

class SeachMoviesViewController: UIViewController {
    // MARK: - Global Variables
    var registerData:[SearchedMovie] = []
    var searching:Bool?
    var movieSearchViewModel = MovieSearchViewModel()
    var isFirstLoaded = true
    
    // MARK: - Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "MovieSearchTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieSearchTableViewCell")

        registerData = DataBaseManager.shared.fetch()
        self.tableView.reloadData()
    }
}
// MARK: - TableViewDataSource
extension SeachMoviesViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFirstLoaded{
            return registerData.count
        }else{
            return movieSearchViewModel.movieSearchList?.results?.count ?? 0
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieSearchTableViewCell", for: indexPath) as? MovieSearchTableViewCell else { return UITableViewCell() }
        
        if self.isFirstLoaded{
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                let data = self.registerData[indexPath.row]
                
                if data.movieImage != ""
                {
                    cell.movieImage.contentMode = .scaleAspectFit
                    if let url = URL(string:"https://image.tmdb.org/t/p/original\(data.movieImage)") {
                        cell.movieImage.kf.setImage(with: url)
                    }
                }
                else
                {
                    cell.movieImage.image = UIImage(named: "tv")
                }
                cell.movieName.text = data.movieName
            }
        }else{
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else {return}
                if self.movieSearchViewModel.movieSearchList?.results?.count ?? 0 > 0  {
                    let data = self.movieSearchViewModel.movieSearchList?.results?[indexPath.row]
                    
                    if data?.posterPath != ""
                    {
                        cell.movieImage.contentMode = .scaleAspectFit
                        if let url = URL(string:"https://image.tmdb.org/t/p/original\(data?.posterPath ?? "")") {
                            cell.movieImage.kf.setImage(with: url)
                        }
                    }
                    else
                    {
                        cell.movieImage.image = UIImage(named: "tv")
                    }
                    cell.movieName.text = data?.title
                }
            }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.isFirstLoaded{
            let data = registerData[indexPath.row]
//            let movieDetails = movieSearchViewModel.movieSearchList?.results?[indexPath.row]
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
            vc.moviedetailsViewModel.movie_id = Int(data.id)
            vc.moviecastViewModel.movie_id = Int(data.id)
            vc.moviereviewViewModel.movie_id = Int(data.id)
            vc.movieSimilarViewModel.movie_id = Int(data.id)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
        else{
            let movieDetails = movieSearchViewModel.movieSearchList?.results?[indexPath.row]

            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
            DataBaseManager.shared.updateData(result: movieDetails)
            vc.moviedetailsViewModel.movie_id = movieDetails?.id
            vc.moviecastViewModel.movie_id = movieDetails?.id
            vc.moviereviewViewModel.movie_id = movieDetails?.id
            vc.movieSimilarViewModel.movie_id = movieDetails?.id
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
    // MARK: - TableViewDelegate
    extension SeachMoviesViewController:UITableViewDelegate{
      
    }
    // MARK: - SearchBar delegate
    extension SeachMoviesViewController: UISearchBarDelegate{
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            isFirstLoaded = false
            // searching = true
            self.movieSearchViewModel.fetchMovieDetails(searchStr: searchText) { [weak self] in
//                var lastFive = [Result]()
//                if (self?.movieSearchViewModel.movieSearchList?.results?.count ?? 0) > 5 {
//                    lastFive = (self?.movieSearchViewModel.movieSearchList?.results ?? []).suffix(5)
//                }else{
//                    lastFive = self?.movieSearchViewModel.movieSearchList?.results ?? []
//                }
                self?.registerData = DataBaseManager.shared.fetch()
                self?.tableView.reloadData()
            }
        }
    }

