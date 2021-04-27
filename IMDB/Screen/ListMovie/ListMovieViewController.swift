//
//  ListMovieViewController.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import UIKit

class ListMovieViewController: BaseViewController {
    
    @IBOutlet var categoryButton: UIButton!
    @IBOutlet var tableView: UITableView!
    
    private let viewmodel = ListMovieViewModel()
    
    private var listGenre: [Genre] = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "IMDB Movie"
        initUI()
        initData()
    }
}

// MARK: - Setup UI
extension ListMovieViewController{
    func initUI() {
        initTableView()
        initSpinner()
    }
    
    func initTableView(){
        tableView.register(UINib(nibName: "ListMovieTableViewCell", bundle: nil), forCellReuseIdentifier: "ListMovieTableViewCell")
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
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
extension ListMovieViewController{
    func initData() {
        //get list genre
        self.viewmodel.getListGenre()
        
        // det list movie data
        self.fetchListMovie()
    }
}

// MARK: - Request
extension ListMovieViewController{
    
    func fetchListMovie() {
        self.viewmodel.getListMovie()
        
        // success response
        self.viewmodel.successRequest = { [weak self] (type) in
            switch type {
            case .movie:
                self?.tableView.reloadData()
                self?.tableView.layoutIfNeeded()
                if self?.viewmodel.page ?? 0 < 2 && self?.viewmodel.listMovie.count ?? 0 > 0 {
                    self?.tableView.scrollToRow(at: IndexPath.init(row: 0, section: 0), at: .top, animated: true)
                }
            case .genre:
                break
            }
        }
        
        // failure response
        self.viewmodel.failureRequest = { [weak self] in
            self?.createAlert(message: self?.viewmodel.errorMessage ?? "", firstCompletion: {
                self?.dismiss(animated: true, completion: nil)
            })
        }
    }
}

// MARK: - Action
extension ListMovieViewController{
    @IBAction func onCategoryPressed(_ sender: Any) {
        showActionSheet()
    }
}

// MARK: - Method
extension ListMovieViewController{
    
    // action sheet  for select category
    func showActionSheet(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        self.viewmodel.listGenre?.genres?.forEach { (item) in
            let action = UIAlertAction(title: item.name, style: .default) { (action) in
                self.viewmodel.selectedGenre = "\(item.id ?? 0)"
                self.viewmodel.page = 1
                self.fetchListMovie()
            }
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - tableView
extension ListMovieViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewmodel.listMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListMovieTableViewCell") as! ListMovieTableViewCell
        cell.selectionStyle = .none
        cell.setData(data:self.viewmodel.listMovie[indexPath.row])
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailMovieViewController()
        vc.idMovie = self.viewmodel.listMovie[indexPath.row].id
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // load more
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if (offsetY + scrollView.frame.size.height) >= contentHeight {
            if (self.viewmodel.page < self.viewmodel.listMovieModel?.totalPages ?? 0){
                self.viewmodel.page = self.viewmodel.page + 1
                self.viewmodel.getListMovie()
            }
        }
    }
}

