//
//  UIButton.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation
import UIKit

extension UIButton{
    func setPrimaryButton() {
        self.backgroundColor = UIColor(hex: Constant.BASE_COLOR)
        self.setTitleColor(UIColor.white, for: .normal)
    }
}
