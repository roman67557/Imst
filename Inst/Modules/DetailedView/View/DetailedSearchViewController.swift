//
//  DetailedSearchViewController.swift
//  wq
//
//  Created by Роман on 02.01.2022.
//

import UIKit

class DetailedSearchViewController: UIViewController, UICollectionViewDataSource {
  
  var presenter: DetailedViewPresenterProtocol?
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    layout.minimumLineSpacing = 0
    layout.itemSize = .init(width: view.frame.width, height: view.frame.height)
    layout.scrollDirection = .horizontal
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.contentInsetAdjustmentBehavior = .never
    collectionView.isPagingEnabled = true
    collectionView.decelerationRate = .fast
    collectionView.dataSource = self
    collectionView.backgroundColor = .white
    collectionView.register(DetailedCollectionViewCell.self, forCellWithReuseIdentifier: DetailedCollectionViewCell.identifier)
    return collectionView
  }()
  
  private var results: Types?
  private var index: Int?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setup()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    setupTabBarHidden(false)
  }
  
  private func setup() {
    presenter?.setImg()
    addSubViews()
    setupColor()
    setupGestureRecognizers()
    setupTabBarHidden(true)
    setupConstraints()
    
    scrollToSelectedImage()
  }
  
  private func addSubViews() {
    [collectionView].forEach { elem in
      view.addSubview(elem)
      elem.translatesAutoresizingMaskIntoConstraints = false
    }
  }
  
  private func setupColor() {
    view.backgroundColor = .white
  }
  
  private func setupTabBarHidden(_ bool: Bool) {
    tabBarController?.tabBar.isHidden = bool
  }
  
  private func setupConstraints() {
    collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    collectionView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    collectionView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
  }
  
  private func scrollToSelectedImage() {
    self.collectionView.layoutIfNeeded()
    self.collectionView.scrollToItem(at: IndexPath(item: index ?? 0, section: 0), at: .centeredHorizontally, animated: false)
  }
  
  private func setupGestureRecognizers() {
    let panGesture = PanDirectionGestureRecognizer(direction: PanDirection.vertical, target: self, action: #selector(wasDragged(_:)))
    collectionView.addGestureRecognizer(panGesture)
    collectionView.isUserInteractionEnabled = true
  }
  
  @objc private func wasDragged(_ gesture: PanDirectionGestureRecognizer) {
    guard let view = gesture.view else { return }
    
    let translation = gesture.translation(in: self.view)
    view.center = CGPoint(x: self.view.bounds.midX, y: self.view.bounds.midY + translation.y)
    
    if gesture.state == UIGestureRecognizer.State.ended {
      self.navigationController?.popViewController(animated: true)
    }
  }
  
}

extension DetailedSearchViewController: DetailedViewProtocol {
  
  func setImg(img: Types?, index: Int) {
    self.results = img
    self.index = index
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    switch results {
    case .results(let results):
      return results.count
    case .shooterdImages(let shootedImages):
      return shootedImages.count
    default:
      return 0
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailedCollectionViewCell.identifier, for: indexPath) as? DetailedCollectionViewCell
    
    switch results {
    case .results(let results):
      let photo = results[indexPath.item]
      cell?.configure(with: photo)
    case .shooterdImages(let shootedImages):
      let photo = shootedImages[indexPath.row]
      cell?.configure(with: photo)
    default:
      break
    }
    
    return cell ?? UICollectionViewCell()
  }
  
}

