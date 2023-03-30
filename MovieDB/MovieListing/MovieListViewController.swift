//
//  MovieListViewController.swift
//  MovieDB
//
//  Created by NeoSOFT on 01/03/23.


    import UIKit
    import Kingfisher
    class MovieListViewController: UIViewController {
      
        var listMovieViewModel = MovieListViewModel()
        //lazy var
       
        @IBOutlet weak var tableView: UITableView!
        override func viewDidLoad() {
            super.viewDidLoad()
            fetchReloadData()
        }
        func fetchReloadData(){
            listMovieViewModel.fetchMovieDetails {
                self.tableView.reloadData()
            }
        }
        @IBAction func actionOnSearchBtn(_ sender: Any) {
            
                        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyBoard.instantiateViewController(withIdentifier: "SeachMoviesViewController") as! SeachMoviesViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        func navigateToDetailsVC(movieDetails: Result?){
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            if let vc = storyBoard.instantiateViewController(withIdentifier: "MovieDetailsViewController") as? MovieDetailsViewController {
                vc.moviedetailsViewModel.movie_id = movieDetails?.id
                vc.moviecastViewModel.movie_id = movieDetails?.id
                vc.moviereviewViewModel.movie_id = movieDetails?.id
                vc.movieSimilarViewModel.movie_id = movieDetails?.id
               self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    extension MovieListViewController:UITableViewDataSource{
     
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return listMovieViewModel.movieList?.results?.count ?? 0
        }
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else {
                return UITableViewCell()
            }
            if let productDetails = self.listMovieViewModel.movieList?.results?[indexPath.row] {
                cell.setData(dataSource: productDetails)
            }
            
            return cell
        }
    }

extension MovieListViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let movieDetails = listMovieViewModel.movieList?.results?[indexPath.row]{
            self.navigateToDetailsVC(movieDetails: movieDetails)
        }
    }
    
}


   


