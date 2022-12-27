//
//  Presenter.swift
//  wq
//
//  Created by Роман on 13.01.2022.
//

import Foundation
import UIKit

//MARK: - Protocols
protocol SearchViewProtocol: AnyObject {
  
  
}

protocol SearchViewPresenterProtocol: AnyObject {
  
  init(view: SearchViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
  
  func fetchImages(searchTerm: String) async throws -> [Results]
  func openDetails(img: Types?, view: UIViewController, index: Int)
}

//MARK: - Presenter
class SearchPresenter: SearchViewPresenterProtocol {
  
  weak var view: SearchViewProtocol?
  let networkService: NetworkServiceProtocol
  var router: RouterProtocol?
  
  required init(view: SearchViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
    self.view = view
    self.networkService = networkService
    self.router = router
  }
  
  func fetchImages(searchTerm: String) async throws -> [Results] {
    return try await networkService.request(searchTerm: searchTerm)
  }
  
  func openDetails(img: Types?, view: UIViewController, index: Int) {
    router?.moveToDetailedController(img: img, view: view, index: index)
  }
  
}


