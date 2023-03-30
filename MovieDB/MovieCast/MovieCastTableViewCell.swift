//
//  MovieCastTableViewCell.swift
//  MovieDB
//
//  Created by NeoSOFT on 02/03/23.
//

import UIKit

enum TypeData {
    case cast
    case crew
    case similar
}

class MovieCastTableViewCell: UITableViewCell {
    
    @IBOutlet weak var typeSection: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var moviecastViewModel : MovieCastViewModel?
    var movieCast : MovieCast?
    var similarMovie : MovieSimilar?
    var typeData : TypeData = .cast
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.register(UINib(nibName: "MovieCastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieCastCollectionViewCell")
        
    }
    
    func setDataonCell(_ data: MovieCast) {
        self.movieCast = data
        self.collectionView.reloadData()
    }
    func setCell(_ resultdata: MovieSimilar){
        self.similarMovie = resultdata
        self.collectionView.reloadData()
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MovieCastTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch typeData{
        case .cast:
            return movieCast?.cast.count ?? 0

        case .crew:
            return movieCast?.crew.count ?? 0

        case .similar:
            return similarMovie?.results?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCastCollectionViewCell", for: indexPath as IndexPath) as! MovieCastCollectionViewCell
        cell.typeData = self.typeData
       // switch movieCast?.crew[indexPath.item]
        switch typeData{
        case .cast:
            let imagedata = movieCast?.cast[indexPath.item]
            if imagedata?.profilePath != ""
            {
                cell.castImage.contentMode = .scaleAspectFit
                if let url = URL(string:"https://image.tmdb.org/t/p/original\(imagedata?.profilePath ?? "")") {
                    cell.castImage.kf.setImage(with: url)
                }
            }
            else
            {
                cell.castImage.image = UIImage(named: "tv")
            }
            cell.castName.text = imagedata?.name
            self.typeSection.text = "CAST"
        case .crew:
            let imagedata = movieCast?.crew[indexPath.item]
            if imagedata?.profilePath != ""
            {
                cell.castImage.contentMode = .scaleAspectFit
                if let url = URL(string:"https://image.tmdb.org/t/p/original\(imagedata?.profilePath ?? "")") {
                    cell.castImage.kf.setImage(with: url)
                }
            }
            else
            {
                cell.castImage.image = UIImage(named: "tv")
            }
            cell.castName.text = imagedata?.name
            self.typeSection.text = "CREW"
        case .similar:
            let similardata = similarMovie?.results?[indexPath.item]
            if similardata?.backdropPath != ""
            {
                cell.castImage.contentMode = .scaleAspectFit
                if let url = URL(string:"https://image.tmdb.org/t/p/original\(similardata?.backdropPath ?? "")") {
                    cell.castImage.kf.setImage(with: url)
                }
            }
            else
            {
                cell.castImage.image = UIImage(named: "tv")
            }
            cell.castName.text = similardata?.title
            self.typeSection.text = "Similar Movies"
            
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 160)
    }
    
    
}
