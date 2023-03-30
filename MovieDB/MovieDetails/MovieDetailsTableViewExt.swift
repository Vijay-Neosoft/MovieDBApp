//
//  MovieDetailsTableViewExt.swift
//  MovieDB
//
//  Created by NeoSOFT on 14/03/23.
//

import Foundation
import UIKit

// MARK: - TableViewDataSource
extension MovieDetailsViewController:UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailsTableViewCell", for: indexPath) as? MovieDetailsTableViewCell else {
                return UITableViewCell()
            }
            let moviedata = moviedetailsViewModel.movieList
            if moviedata?.posterPath != ""
            {
                cell.movieImage.contentMode = .scaleAspectFit
                if let url = URL(string:"https://image.tmdb.org/t/p/original\(moviedata?.posterPath ?? "")") {
                    cell.movieImage.kf.setImage(with: url)
                }
            }
            else
            {
                cell.movieImage.image = UIImage(named: "tv")
            }
            
            cell.movieName.text = moviedata?.originalTitle
            cell.movieReleaseDateandtime.text = moviedata?.releaseDate
            cell.movieRating.text = "\(moviedata?.voteAverage ?? 0)/10"
            
            cell.movieDescription.text = moviedata?.overview
            return cell
            
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCastTableViewCell", for: indexPath) as? MovieCastTableViewCell else {
                return UITableViewCell()
            }
            cell.typeData = .cast
            if let data = moviecastViewModel.movieCast {
                cell.setDataonCell(data)
            }
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCastTableViewCell", for: indexPath) as? MovieCastTableViewCell else {
                return UITableViewCell()
            }
            cell.typeData = .crew

            if let data = moviecastViewModel.movieCast {
                cell.setDataonCell(data)
            }
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieReviewTableViewCell", for: indexPath) as? MovieReviewTableViewCell else {
                return UITableViewCell()
            }
            let details = moviereviewViewModel.moviereview
            cell.viewReviewsButton.addTarget(self, action: #selector(action_BtnViewMore(_:)), for: .touchUpInside)
            if self.isExpanded == true {
                cell.reviewsLabel.numberOfLines = 0
                cell.viewReviewsButton.setTitle("View Less Review", for: .normal)
            } else {
                cell.reviewsLabel.numberOfLines = 5
                cell.viewReviewsButton.setTitle("View More Review", for: .normal)
            }
            
            if details?.results?.indices.contains(0) ?? false{
                cell.reviewsLabel.text = details?.results?[0].content
            }
            cell.titleLabel.text = "Reviews"
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCastTableViewCell", for: indexPath) as? MovieCastTableViewCell else {
                return UITableViewCell()
            }
            cell.typeData = .similar

            if let data = movieSimilarViewModel.moviesimilar{
                cell.setCell(data)
            }
            return cell
        default: break
            
        }
        return UITableViewCell()
       
    }

    
}
extension MovieDetailsViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension MovieDetailsViewController{
    @objc func action_BtnViewMore(_ sender:UIButton){
        self.isExpanded.toggle()
        self.tableView.reloadData()
    }
}
