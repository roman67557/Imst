//
//  Router.swift
//  wq
//
//  Created by Роман on 29.01.2022.
//

import Foundation
import UIKit
import FontAwesome_swift

protocol RouterMain {
  var tabBarController: UITabBarController { get set }
  var assemblyBuilder: AssemblyBuilderProtocol { get set }
}

protocol RouterProtocol: RouterMain {
  func initialViewController()
  func moveToDetailedController(img: Types?, view: UIViewController, index: Int)
  func openCameraView(view: UIViewController)
}

class Router: RouterProtocol {
  
  var tabBarController: UITabBarController
  var assemblyBuilder: AssemblyBuilderProtocol
  
  init(tabBarController: UITabBarController, assemblyBuilder: AssemblyBuilderProtocol) {
    self.tabBarController = tabBarController
    self.assemblyBuilder = assemblyBuilder
  }
  
  func initialViewController() {
    
    let mainView = assemblyBuilder.createMainModule(router: self)
    let searchView = assemblyBuilder.createSearchModule(router: self)
    let updatesView = assemblyBuilder.createUpdatesModule(router: self)
    let userView = assemblyBuilder.createUserModule(router: self)
    
    tabBarController.setViewControllers([mainView, searchView, updatesView, userView], animated: true)
    tabBarController.tabBar.isHidden = false
    tabBarController.tabBar.backgroundColor = .white
    
    let imagesArray = [UIImage.fontAwesomeIcon(name: .houseUser, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)),
                       UIImage.fontAwesomeIcon(name: .search, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)),
                       UIImage.fontAwesomeIcon(name: .heart, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30)),
                       UIImage.fontAwesomeIcon(name: .user, style: .solid, textColor: .black, size: CGSize(width: 30, height: 30))]
    
    let viewControllers = [0: mainView, 1: searchView, 2: updatesView, 3: userView]
    for (index, VC) in (viewControllers) {
      VC.tabBarItem = UITabBarItem(title: "", image: imagesArray[index], tag: index)
    }
  }
  
  func moveToDetailedController(img: Types?, view: UIViewController, index: Int) {
    guard let img = img else { return }
    let detailedVC = assemblyBuilder.createDetailedController(img: img, router: self, index: index)
    view.navigationController?.pushViewController(detailedVC, animated: true)
  }
  
  func openCameraView(view: UIViewController) {
    let cameraView = assemblyBuilder.createCameraViewCtonrtoller(router: self)
    view.present(cameraView, animated: true)
  }
}
