//
//  MainPresenter.swift
//  wq
//
//  Created by Роман on 26.01.2022.
//

import Foundation
import UIKit

protocol MainViewProtocol: AnyObject {
  
  func handleRefreshControl(sender: UIRefreshControl)
}

protocol MainViewPresenterProtocol: AnyObject {
  
  init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol)
  
  func fetchImages(searchTerm: String) async throws -> [Results]
  func openCamera(view: UIViewController)
}

class MainViewPresenter: MainViewPresenterProtocol {
  
  var view: MainViewProtocol?
  var networkService: NetworkServiceProtocol
  var router: RouterProtocol?
  
  required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
    
    self.view = view
    self.networkService = networkService
    self.router = router
  }
  
  func openCamera(view: UIViewController) {
    
    router?.openCameraView(view: view)
  }
  
  func fetchImages(searchTerm: String) async throws -> [Results] {
    
    return try await networkService.request(searchTerm: searchTerm)
  }
}
