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
  func openAlert(error: String)
}

class SearchPresenter: SearchViewPresenterProtocol {
  
  //MARK: - Private Properties
  
  private weak var view: SearchViewProtocol?
  private let networkService: NetworkServiceProtocol
  private let router: RouterProtocol?
  
  //MARK: - Initializers
  
  required init(view: SearchViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
    self.view = view
    self.networkService = networkService
    self.router = router
  }
  
  //MARK: - Public Methods
  
  public func fetchImages(searchTerm: String) async throws -> [Results] {
    return try await networkService.request(searchTerm: searchTerm)
  }
  
  public func openDetails(img: Types?, view: UIViewController, index: Int) {
    router?.moveToDetailedController(img: img, view: view, index: index)
  }
  
  public func openAlert(error: String) {
    guard let vc = view as? UIViewController else { return }
    router?.openAlert(view: vc, error: error)
  }
  
}


