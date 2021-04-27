//
//  HeaderMovieTableViewCell.swift
//  IMDB
//
//  Created by ilhamsaputra on 27/04/21.
//

import UIKit

class HeaderMovieTableViewCell: UITableViewCell {
    @IBOutlet weak var backdropImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setData(data: DetailMovieModel?) {
        titleLabel.text = data?.title
        releaseDateLabel.text = "Release Date: \(data?.releaseDate ?? "-")"
        overviewLabel.text = data?.overview
        
        posterImage.layer.cornerRadius = 8
        if let url = URL(string: Constant.BASE_URL_IMAGE + (data?.posterPath ?? "" )){
            posterImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), completed: nil)
        }else{
            posterImage.image = UIImage(named: "placeholder")
        }
        if let url = URL(string: Constant.BASE_URL_IMAGE + (data?.backdropPath ?? "" )){
            backdropImage.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"), completed: nil)
        }else{
            backdropImage.image = UIImage(named: "placeholder")
        }
    }
    
}
