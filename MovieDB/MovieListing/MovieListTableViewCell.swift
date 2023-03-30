//
//  MovieListTableViewCell.swift
//  MovieDB
//
//  Created by NeoSOFT on 01/03/23.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    @IBOutlet weak var movieReleaseDate: UILabel!
    @IBOutlet weak var movieImage: UIImageView!

    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var likesAndRatings: UILabel!
    @IBOutlet weak var ratingImage: UIImageView!
    @IBOutlet weak var calendarImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setData(dataSource: Result){
        movieName.text = dataSource.title
        movieReleaseDate.text = dataSource.releaseDate
        likesAndRatings.text = dataSource.ratingDetails
        if let urlName =  dataSource.posterPath {
            let urlPath = "https://image.tmdb.org/t/p/original" + urlName
            movieImage.downloaded(from: urlPath)
        }      
        
    }

   
}


extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}

