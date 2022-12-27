//
//  FifthViewController.swift
//  wq
//
//  Created by Роман on 23.11.2021.
//

import UIKit
import CoreData

class UpdatesViewController: UIViewController {
  
  public var presenter: UpdatesViewPresenterProtocol!
  
  private let fetchedResultController = DatabaseHandler.shared.fetchedResultsController(entityName: "ShooterdImages", keyForSort: "date")
  
  private var myTableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = .white
    self.navigationItem.title = "Updates"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    setup()
  }
  
  private func setup() {
    
    addSubViews()
    setupFetchedResultController()
    setupTableView()
    setupConstraints()
  }
  
  private func addSubViews() {
    
    [myTableView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview($0)
    }
  }
  
  private func setupFetchedResultController() {
    
    try? fetchedResultController.performFetch()
    fetchedResultController.delegate = self
  }
  
  private func setupTableView() {
    
    myTableView.register(UpdatesTableViewCell.self, forCellReuseIdentifier: UpdatesTableViewCell.identifier)
    myTableView.delegate = self
    myTableView.dataSource = self
  }
  
  private func setupConstraints() {
    
    myTableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    myTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    myTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    myTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
  }
  
}

extension UpdatesViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let sections = fetchedResultController.sections else { return 0 }
    return sections[section].numberOfObjects
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = myTableView.dequeueReusableCell(withIdentifier: UpdatesTableViewCell.identifier, for: indexPath) as? UpdatesTableViewCell
    guard let data = fetchedResultController.object(at: indexPath) as? ShooterdImages else { return UITableViewCell () }
    
    cell?.setup(data: data)
    
    return cell ?? UITableViewCell()
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 70
  }
  
}

extension UpdatesViewController: UpdatesViewProtocol {
  
}

extension UpdatesViewController: NSFetchedResultsControllerDelegate {
  
  func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    myTableView.beginUpdates()
  }
  
  func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
    
    switch type {
    case .insert:
      guard let indexPath = newIndexPath else { return }
      myTableView.insertRows(at: [indexPath], with: .automatic)
      
    case .update:
      guard let indexPath = indexPath,
            let data = fetchedResultController.object(at: indexPath) as? ShooterdImages else { return }
      let cell = myTableView.cellForRow(at: indexPath) as? UpdatesTableViewCell
      cell?.setup(data: data)
      
    case .move:
      guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
      myTableView.moveRow(at: indexPath, to: newIndexPath)
      
      
    case .delete:
      guard let indexPath = indexPath else { return }
      myTableView.deleteRows(at: [indexPath], with: .automatic)
      
    @unknown default:
      fatalError()
    }
  }
  
  func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    myTableView.endUpdates()
  }
  
}

