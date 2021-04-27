//
//  DetailMovieViewModel.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation
import UIKit

enum EnumDetailRequest{
    case detail
    case review
}

class DetailMovieViewModel {
    
    var showProgress: (() -> ())?
    var hideProgress: (() -> ())?
    var successRequest: ((EnumDetailRequest) -> ())?
    var failureRequest: (() -> ())?
    
    var detailMovieModel:DetailMovieModel?
    var reviewsMovieModel:ReviewMovieModel?
    var errorMessage:String = ""
    var listReview:[Reviews] = []
    var page:Int = 1
    
    func getDetailMovie(id:Int) {
        self.showProgress?()
        let detailMovieService = DetailMovieService()
        detailMovieService.url = Constant.BASE_URL + Constant.DETAIL + "\(id)?api_key=\(Constant.APIKEY)"
        BaseNetwork.request(req: detailMovieService) { (result) in
            self.hideProgress?()
            switch result{
            case.success(let response):
                self.detailMovieModel = response
                self.successRequest?(.detail)
            case .failure(let error):
                self.errorMessage = error ?? ""
                self.failureRequest?()
            }
        }
    }
    
    func getReviewMovie(id:Int) {
        self.showProgress?()
        let reviewsMovieService = ReviewMovieService()
        reviewsMovieService.url = Constant.BASE_URL + Constant.DETAIL + "\(id)/reviews?api_key=\(Constant.APIKEY)&page=\(page)"
        BaseNetwork.request(req: reviewsMovieService) { (result) in
            self.hideProgress?()
            switch result{
            case.success(let response):
                self.reviewsMovieModel = response
                self.createListReview()
                self.successRequest?(.review)
            case .failure(let error):
                self.errorMessage = error ?? ""
                self.failureRequest?()
            }
        }
    }
    
    private func createListReview(){
        if page < 2 { self.listReview.removeAll() }
        self.reviewsMovieModel?.reviews.forEach({ (review) in
            self.listReview.append(review)
        })
    }
}
