//
//  ReviewTableViewCell.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewRounded: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // Mapping data review to uitableview cell
    func setData(data: Reviews) {
        self.reviewLabel.text = data.content
        self.authorLabel.text = data.author
    }
}
