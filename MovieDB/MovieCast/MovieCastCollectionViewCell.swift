//
//  MovieCastCollectionViewCell.swift
//  MovieDB
//
//  Created by NeoSOFT on 02/03/23.
//

import UIKit

class MovieCastCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var castName: UILabel!
    
    var typeData : TypeData = .cast{
        didSet{
            switch typeData{
            case .cast,.crew:
                castImage.layer.cornerRadius = 45//castImage.frame.height / 2
                castImage.layer.masksToBounds = true
            case .similar:
                castImage.layer.cornerRadius = 0//castImage.frame.height / 2
                castImage.layer.masksToBounds = false
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
            // Initialization code
    }

}
