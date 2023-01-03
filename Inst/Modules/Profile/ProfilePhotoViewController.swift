//
//  ProfilePhotoViewController.swift
//  ??
//
//  Created by Роман on 28.02.2022.
//

import UIKit

class ProfilePhotoViewController: UIViewController, Animation {
  
  private var imgView = UIImageView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    setup()
  }
  
  private func setup() {
    addSubViews()
    setupImageView()
  }
  
  private func addSubViews() {
    [imgView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
  }
  
  private func setupImageView() {
    imgView.contentMode = .scaleAspectFit
    imgView.backgroundColor = .systemGray5
  }
  
  private func setupConstraints() {
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    tabBarController?.tabBar.isHidden = true
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    self.tabBarController?.tabBar.isHidden = false
    self.navigationController?.isNavigationBarHidden = false
  }
  
}



