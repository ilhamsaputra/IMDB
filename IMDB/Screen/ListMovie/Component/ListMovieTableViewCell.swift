//
//  ListMovieTableViewCell.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import UIKit
import SDWebImage

class ListMovieTableViewCell: UITableViewCell {

    @IBOutlet weak var viewRounded: UIView!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Create rounded and shadow to view
        self.viewRounded.setRoundedShadowView()
    }

    // Mapping data movie to uitableview cell
    func setData(data: Movie) {
        titleLabel.text = data.title
        releaseDateLabel.text = data.releaseDate
        if let url = URL(string: Constant.BASE_URL_IMAGE + data.posterPath){
            posterImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), completed: nil)
        }else{
            posterImage.image = UIImage(named: "placeholder")
        }
    }
}
