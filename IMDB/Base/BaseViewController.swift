//
//  BaseViewController.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation
import UIKit
import MBProgressHUD

class BaseViewController : UIViewController {
    typealias alertCallBack = () -> ()
    
    var hud: MBProgressHUD?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // config navigation controller
        self.navigationController?.navigationBar.barTintColor = UIColor(hex: Constant.BASE_COLOR)
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    // create loading
    func showHUD(text: String? = "Please wait", view: UIView? = nil) {
        if self.hud != nil { self.hud!.hide(animated: false) }
        self.hud = MBProgressHUD.showAdded(to: view!, animated: true)
        self.hud!.label.text = text
        self.hud!.mode = .indeterminate
    }
    
    // hide loading
    func hideHUD() {
        if self.hud != nil {
            self.hud!.hide(animated: false)
            self.hud = nil
        }
    }
    
    // create palert
    func createAlert(title: String = "", message: String, firstButtonTitle: String = "OK", secondButtonTitle: String = "", firstCompletion: alertCallBack?, secondCompletion: alertCallBack? = nil, withTwoButton: Bool = false){
        let alert = UIAlertController(title: title,message: message, preferredStyle: .alert)
        let firstAction = UIAlertAction(title: firstButtonTitle, style: .default) { alert in
            if firstCompletion != nil {
                firstCompletion!()
            }
        }
        alert.addAction(firstAction)
        
        
        if withTwoButton {
            let secondAction = UIAlertAction(title: secondButtonTitle, style: .default) { alert in
                if secondCompletion != nil {
                    secondCompletion!()
                }
            }
            alert.addAction(secondAction)
        }
        self.present(alert, animated: true, completion: nil)
    }
}


