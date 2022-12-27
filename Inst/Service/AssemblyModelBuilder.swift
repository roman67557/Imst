//
//  AssemblyModelBuilder.swift
//  wqTests
//
//  Created by Роман on 13.01.2022.
//

import Foundation
import UIKit

protocol AssemblyBuilderProtocol {
  func createMainModule(router: RouterProtocol) -> UINavigationController
  func createSearchModule(router: RouterProtocol) -> UINavigationController
  func createUpdatesModule(router: RouterProtocol) -> UINavigationController
  func createUserModule(router: RouterProtocol) -> UINavigationController
  
  func createDetailedController(img: Types, router: RouterProtocol, index: Int) -> UIViewController
  func createImagePicker(router: RouterProtocol) -> UIImagePickerController
}

class AssemblyModelBuilder: AssemblyBuilderProtocol {
  
  func createMainModule(router: RouterProtocol) -> UINavigationController {
    let view = MainViewController()
    let networkService = NetworkService()
    let presenter = MainViewPresenter(view: view, networkService: networkService, router: router)
    view.presenter = presenter
    
    let navigationController = UINavigationController(rootViewController: view)
    
    return navigationController
  }
  
  func createSearchModule(router: RouterProtocol) -> UINavigationController {
    let layout = UICollectionViewFlowLayout()
    let view = SearchViewController(collectionViewLayout: layout)
    let networkService = NetworkService()
    let presenter = SearchPresenter(view: view, networkService: networkService, router: router)
    view.presenter = presenter
    
    let navigationController = UINavigationController(rootViewController: view)
    
    return navigationController
  }
  
  func createUpdatesModule(router: RouterProtocol) -> UINavigationController {
    let view = UpdatesViewController()
    let presenter = UpdatesViewPresenter(view: view, router: router)
    view.presenter = presenter
    
    let navigationController = UINavigationController(rootViewController: view)
    
    return navigationController
  }
  
  func createUserModule(router: RouterProtocol) -> UINavigationController {
    let view = UserViewController()
    let presenter = UserViewPresenter(view: view, router: router)
    view.presenter = presenter
   
    let navigationController = UINavigationController(rootViewController: view)
    
    return navigationController
  }
  
  func createDetailedController(img: Types, router: RouterProtocol, index: Int) -> UIViewController {
    let view = DetailedSearchViewController()
    let presenter = DetailedViewPresenter(view: view, img: img, router: router, index: index)
    view.presenter = presenter
    
    return view
  }
  
  func createImagePicker(router: RouterProtocol) -> UIImagePickerController {
    let view = ImagePickerController()
    let presenter = ImagePickerPresenter(view: view, router: router)
    view.presenter = presenter
    
    return view
  }
  
}
