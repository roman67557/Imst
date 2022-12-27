//
//  ViewControllerCellTableViewCell.swift
//  wq
//
//  Created by Роман on 14.01.2022.
//

import UIKit

class MainViewControllerCell: UITableViewCell {
  
  //MARK: - Public Properties
  static var identifier = "MainViewControllerCell"
  
  //MARK: - Private Properties
  private var activityIndicatorView = UIActivityIndicatorView()
  private var cellImageView = UIImageView()
  
  private var loadImageTask: Task<Void, Never>?
  
  //MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    self.selectionStyle = .none
  }
  
  required init?(coder: NSCoder) {
    
    fatalError("init(coder:) has not been implemented")
  }
  
  //MARK: - Public Methods
  public func configure(with result: Results) {
    guard let string = result.urls.regular,
          let url = URL(string: string) else { return }
    
    addSubViews()
    setupImageView(url: url)
    setupConstraints()
  }
  
  //MARK: - Private Methods
  private func addSubViews() {
   
    [cellImageView, activityIndicatorView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
      addSubview($0)
    }
  }
  
  private func setupImageView(url: URL) {
    loadImageTask?.cancel()

    loadImageTask = Task { [weak self] in
        self?.cellImageView.image = nil
        self?.activityIndicatorView.startAnimating()

        do {
            try await self?.cellImageView.setImage(by: url)
            if Task.isCancelled { return }
            self?.cellImageView.contentMode = .scaleAspectFit
        } catch {
            if Task.isCancelled { return }
            self?.cellImageView.image = UIImage(named: "inst")
            self?.cellImageView.contentMode = .scaleAspectFit
        }

        self?.activityIndicatorView.stopAnimating()
    }
  }
  
  private func setupConstraints() {
    
    cellImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
    cellImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
    cellImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    cellImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    
    activityIndicatorView.centerXAnchor.constraint(equalTo: cellImageView.centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: cellImageView.centerYAnchor).isActive = true
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    
    cellImageView.image = nil
  }
  
}
