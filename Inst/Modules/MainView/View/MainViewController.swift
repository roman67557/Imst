//
//  ViewController.swift
//  wq
//
//  Created by Роман on 19.11.2021.
//

import UIKit

class MainViewController: UIViewController {
  
  //MARK: - Public Properties
  var presenter: MainViewPresenterProtocol?
  
  //MARK: - Private Properties
  private var searchTask: Task<Void, Never>?
  
  private var results = [Results]()
  private var refresh = UIRefreshControl()
  private var myTableView = UITableView()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  //MARK: - Private Methods
  
  private func setup() {
    
    addSubViews()
    setupTitleView()
    setUpTableView()
    setupRefresh()
    setupRightBarItem()
    setupConstraints()
    
    photoFetch(searchTerm: "all")
  }
  
  private func addSubViews() {
    
    [myTableView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
  }
  
  private func setupColor() {
    
    self.view.backgroundColor = .white
  }
  
  fileprivate func setupTitleView() {
    
    let leftItem = UIBarButtonItem(title: "Inst", style: .plain, target: self, action: #selector(moveToUp))
    guard let billaBong = UIFont(name: "Billabong", size: 33) else { return }
    leftItem.setTitleTextAttributes([NSAttributedString.Key.font : billaBong], for: .normal)
    leftItem.setTitleTextAttributes([NSAttributedString.Key.font : billaBong], for: .highlighted)
    leftItem.tintColor = .black
    navigationItem.leftBarButtonItem = leftItem
  }
  
  //MARK: - Setup UI Elemenets
  private func setUpTableView() {
    
    myTableView.register(MainViewControllerCell.self, forCellReuseIdentifier: MainViewControllerCell.identifier)
    myTableView.delegate = self
    myTableView.dataSource = self
  }
  
  private func setupRefresh() {
    
    myTableView.refreshControl = self.refresh
    myTableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
  }
  
  private func setupRightBarItem() {
    
    let cameraButton = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: #selector(switchToCamera))
    self.navigationItem.rightBarButtonItem = cameraButton
    cameraButton.tintColor = .black
  }
  
  private func setupConstraints() {
    
    myTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
  }
  
  private func photoFetch(searchTerm: String) {
    searchTask?.cancel()
    results = []
    
    searchTask = Task(operation: { [weak self] in
      do {
        guard let results = try await presenter?.fetchImages(searchTerm: searchTerm) else { return }
        self?.results = results
        self?.myTableView.reloadData()
      } catch {
        print(error.localizedDescription)
      }
    })
  }
  
  //MARK: - @objc methods
  @objc func moveToUp() {
    
    myTableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
  }
  
  @objc func switchToCamera(par: UIBarButtonItem) {
    
    presenter?.openCamera(view: self)
  }
  
}

//MARK: - Extensions
extension MainViewController: MainViewProtocol {
  
  @objc func handleRefreshControl(sender: UIRefreshControl) {
    
    let strings = ["bike", "apple", "naruto", "space", "cake", "flower", "iphone", "macbook", "russia"]
    guard let random = strings.randomElement() else { return }
    
    self.photoFetch(searchTerm: random)
    myTableView.reloadData()
    sender.endRefreshing()
  }
  
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    let currentImage = results[indexPath.item]
    guard let imageHeight = currentImage.height else { return 0.0 }
    guard let imageWidth = currentImage.width else { return 0.0 }
    let widthRatio = CGFloat(imageWidth) / CGFloat(imageHeight)
    return tableView.frame.width / widthRatio + 20
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return results.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = myTableView.dequeueReusableCell(withIdentifier: MainViewControllerCell.identifier, for: indexPath) as? MainViewControllerCell
    let photo = results[indexPath.item]
    cell?.configure(with: photo)
    return cell ?? UITableViewCell()
  }
  
}





