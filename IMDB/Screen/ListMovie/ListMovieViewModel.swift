//
//  ListMovieViewModel.swift
//  IMDB
//
//  Created by ilhamsaputra on 25/04/21.
//

import Foundation

enum EnumTypeHomeRequest {
    case movie
    case genre
}

class ListMovieViewModel {
    
    var showProgress: (() -> ())?
    var hideProgress: (() -> ())?
    var successRequest: ((EnumTypeHomeRequest) -> ())?
    var failureRequest: (() -> ())?
    
    var listMovieModel:ListMovieModel?
    var listGenre:ListGenreModel?
    var listMovie:[Movie] = []
    
    var errorMessage:String = ""
    var page:Int = 1
    var selectedGenre:String = ""
    
    func getListMovie() {
        self.showProgress?()
        let listMovieService = ListMovieService()
        listMovieService.url = Constant.BASE_URL + Constant.DISCOVER + "?api_key=\(Constant.APIKEY)&page=\(page)&with_genres=\(selectedGenre == "0" ? "" : selectedGenre)"
        BaseNetwork.request(req: listMovieService) { (result) in
            self.hideProgress?()
            switch result{
            case.success(let response):
                self.listMovieModel = response
                self.createListMovie()
                self.successRequest?(.movie)
            case .failure(let error):
                self.errorMessage = error ?? ""
                self.failureRequest?()
            }
        }
    }
    
    func getListGenre() {
        self.showProgress?()
        let listGenreService = ListGenreService()
        listGenreService.url = Constant.BASE_URL + Constant.LIST_GENRE + "?api_key=\(Constant.APIKEY)"
        BaseNetwork.request(req: listGenreService) { (result) in
            self.hideProgress?()
            switch result{
            case.success(let response):
                self.listGenre = response
                self.createListGenre()
                self.successRequest?(.genre)
            case .failure(let error):
                self.errorMessage = error ?? ""
                self.failureRequest?()
            }
        }
    }
    
    private func createListMovie(){
        if page < 2 { self.listMovie.removeAll() }
        
        self.listMovieModel?.movies.forEach({ [weak self] (movie) in
            guard let self = self else {return}
            self.listMovie.append(movie)
        })
    }
    
    private func createListGenre(){
        self.listGenre?.genres?.insert(Genre(id:0, name:"All"), at: 0)
    }
}
