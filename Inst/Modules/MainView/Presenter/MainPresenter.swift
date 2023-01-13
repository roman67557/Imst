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
  func openAlert(error: String)
}

final class MainViewPresenter: MainViewPresenterProtocol {
  
  //MARK: - Private Properties\
  
  private weak var view: MainViewProtocol?
  private let networkService: NetworkServiceProtocol
  private let router: RouterProtocol?
  
  //MARK: - Initializers
  
  required init(view: MainViewProtocol, networkService: NetworkServiceProtocol, router: RouterProtocol) {
    self.view = view
    self.networkService = networkService
    self.router = router
  }
  
  //MARK: - Public Methods
  
  public func openCamera(view: UIViewController) {
    router?.openCameraView(view: view)
  }
  
  public func fetchImages(searchTerm: String) async throws -> [Results] {
    return try await networkService.request(searchTerm: searchTerm)
  }
  
  public func openAlert(error: String) {
    guard let vc = view as? UIViewController else { return }
    router?.openAlert(view: vc, error: error)
  }
  
}
