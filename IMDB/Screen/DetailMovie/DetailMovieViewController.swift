//
//  DetailMovieViewController.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import UIKit

class DetailMovieViewController: BaseViewController {
    
    @IBOutlet var tableView: UITableView!
    
    private let viewmodel = DetailMovieViewModel()
    
    var idMovie:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Detail Movie"
        initUI()
        initData()
    }
}

// MARK: - Setup UI
extension DetailMovieViewController{
    func initUI() {
        initTableView()
        initSpinner()
    }
    
    func initTableView(){
        tableView.register(UINib(nibName: "ReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "ReviewTableViewCell")
        tableView.register(UINib(nibName: "HeaderMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderMovieTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    func initSpinner(){
        self.viewmodel.showProgress = { [weak self] in
            self?.showHUD(view: self?.view)
        }
        
        self.viewmodel.hideProgress = {
            self.hideHUD()
        }
    }
}

// MARK: - Setup Data
extension DetailMovieViewController{
    func initData() {
        // request movie detail
        self.fetchDetailMovie()
    }
}

// MARK: - Request
extension DetailMovieViewController{
    func fetchDetailMovie() {
        self.viewmodel.getDetailMovie(id: idMovie ?? 0)
        
        self.viewmodel.successRequest = { [weak self] (type) in
            switch type {
            case .detail:
                self?.viewmodel.getReviewMovie(id: self?.idMovie ?? 0)
            case .review:
                self?.tableView.reloadData()
            }
        }
        
        self.viewmodel.failureRequest = { [weak self] in
            self?.createAlert(message: self?.viewmodel.errorMessage ?? "", firstCompletion: {
                self?.dismiss(animated: true, completion: nil)
            })
        }
    }
}

// MARK: - tableView
extension DetailMovieViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return self.viewmodel.listReview.count > 0 ? "Review" : ""
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return self.viewmodel.listReview.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderMovieTableViewCell") as! HeaderMovieTableViewCell
            cell.selectionStyle = .none
            cell.setData(data: self.viewmodel.detailMovieModel)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewTableViewCell") as! ReviewTableViewCell
            cell.selectionStyle = .none
            cell.setData(data: self.viewmodel.listReview[indexPath.row])
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    // load more
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY + scrollView.frame.size.height) >= contentHeight {
            if (self.viewmodel.page < self.viewmodel.reviewsMovieModel?.totalPages ?? 0){
                self.viewmodel.page = self.viewmodel.page + 1
                self.viewmodel.getReviewMovie(id: self.idMovie ?? 0)
            }
        }
    }
}

