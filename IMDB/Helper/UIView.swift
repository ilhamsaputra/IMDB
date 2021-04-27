//
//  UIView.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation
import UIKit

extension UIView{
    func setRoundedShadowView() {
        self.layer.cornerRadius = 8
        self.viewShadow()
    }
    
    func viewShadow(){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        self.layer.shadowRadius = 1
    }
}
