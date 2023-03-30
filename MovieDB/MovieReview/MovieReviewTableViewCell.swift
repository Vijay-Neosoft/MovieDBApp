//
//  MovieReviewTableViewCell.swift
//  MovieDB
//
//  Created by NeoSOFT on 10/03/23.
//

import UIKit

class MovieReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var viewReviewsButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var reviewsLabel: UILabel!
    @IBOutlet weak var switchlabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.reviewsLabel.numberOfLines = 5
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
