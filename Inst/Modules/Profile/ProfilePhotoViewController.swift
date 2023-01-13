//
//  ProfilePhotoViewController.swift
//  ??
//
//  Created by Роман on 28.02.2022.
//

import UIKit

final class ProfilePhotoViewController: UIViewController, Animation {
  
  //MARK: - Private Properties
  
  private var imgView = UIImageView()
  
  //MARK: - Life Cycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    setup()
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
  
  deinit {
    print("profilephoto deinit")
  }
  
  //MARK: - Private Methods
  
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
  
}



