//
//  SecondViewController.swift
//  wq
//
//  Created by Роман on 19.11.2021.
//

import UIKit

class SearchViewController: UICollectionViewController {
  
  //MARK: - Public Properties
  
  public var presenter: SearchViewPresenterProtocol?
  
  //MARK: - Properties
  private let refresh = UIRefreshControl()
  private var searchController = UISearchController()
  
  private var results = [Results]()
  private var index: Int?
  
  private var searchTask: Task<Void, Never>?
  
  //MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    
    setup()
  }
  
  deinit {
    print("search deinit")
  }
  
  //MARK: - Private Methods
  
  private func setup() {
    
    addSubViews()
    setupNavigationBar()
    setupCollectionView()
    setupRefreshControll()
    fetchDeafaultPhoto()
  }
  
  private func addSubViews() {
    
    [collectionView].forEach {
      
      $0?.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0 ?? UIView())
    }
  }
  
  private func setupNavigationBar() {
    
    navigationItem.title = "Search"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    self.navigationItem.searchController = searchController
    searchController.searchBar.delegate = self
    
    navigationController?.delegate = self
  }
  
  private func setupCollectionView() {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSize(width: (view.frame.width/3)-1, height: (view.frame.width/3)-1)
    layout.sectionInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    layout.minimumInteritemSpacing = 1
    layout.minimumLineSpacing = 1
    layout.scrollDirection = .vertical
    
    collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView?.register(SmallCollectionViewCell.self, forCellWithReuseIdentifier: SmallCollectionViewCell.identifier)
    collectionView?.delegate = self
    collectionView?.dataSource = self
    collectionView?.backgroundColor = .white
    collectionView.keyboardDismissMode = .onDrag
  }
  
  private func setupConstraints() {
    
    collectionView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    collectionView?.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    collectionView?.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    collectionView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
  }
  
  private func fetchDeafaultPhoto() {
    if searchController.searchBar.text?.isEmpty == true {
      searchTask?.cancel()
      results = []
      
      searchTask = Task(operation: { [weak self] in
        do {
          guard let results = try await presenter?.fetchImages(searchTerm: "all") else { return }
          self?.results = results
          self?.collectionView.reloadData()
        } catch {
          print(error.localizedDescription)
        }
      })
    }
  }
  
  private func setupRefreshControll() {
    collectionView?.refreshControl = self.refresh
    collectionView?.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
  }
  
  @objc func handleRefreshControl(sender: UIRefreshControl) {
    self.results.shuffle()
    self.collectionView?.reloadData()
    sender.endRefreshing()
  }
  
}

//MARK: - Extensions

extension SearchViewController {
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return results.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: SmallCollectionViewCell.identifier, for: indexPath) as? SmallCollectionViewCell else {
      return UICollectionViewCell()
    }
    let photo = results[indexPath.item]
    itemCell.configure(with: photo, and: self.presenter)
    return itemCell
  }
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let img = Types.results(self.results)
    let index = indexPath.item
    self.index = indexPath.item
    presenter?.openDetails(img: img, view: self, index: index)
  }
  
}

extension SearchViewController: UISearchBarDelegate {
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if let text = searchBar.text {
      searchTask?.cancel()
      results = []
      
      searchTask = Task(operation: { [weak self] in
        do {
          guard let results = try await presenter?.fetchImages(searchTerm: text) else { return }
          self?.results = results
          self?.collectionView.reloadData()
        } catch {
          self?.presenter?.openAlert(error: error.localizedDescription)
        }
      })
    }
    searchBar.resignFirstResponder()
  }
  
}

extension SearchViewController: SearchViewProtocol {
  
  
}

extension SearchViewController: UINavigationControllerDelegate {
  
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    
    switch operation {
      
    case .push:
      guard let cell = collectionView.cellForItem(at: IndexPath(row: index ?? 0, section: 0)) as? SmallCollectionViewCell,
            let selectedLayout = self.collectionView.layoutAttributesForItem(at: IndexPath(item: index ?? 0, section: 0)),
            let image = cell.searchPageImageView.image else { return .none }
      let selectedCellFrame = collectionView.convert(selectedLayout.frame, to: collectionView.superview)
      
      return Present(image: image, originframe: selectedCellFrame)
      
    case .pop:
      let detailedVC = fromVC as? DetailedSearchViewController
      
      guard let indexPath = detailedVC?.collectionView.indexPathsForVisibleItems.first,
            let cell = detailedVC?.collectionView.cellForItem(at: indexPath) as? DetailedCollectionViewCell,
            let selectedLayout = self.collectionView.layoutAttributesForItem(at: indexPath) else { return .none }
      let returningCellFrame = self.collectionView.convert(selectedLayout.frame, to: self.collectionView.superview)
      
      return Dismiss(finalFrame: returningCellFrame, image: cell.imgView.image ?? UIImage())

    default:
      return .none
    }
  }
  
}
    




