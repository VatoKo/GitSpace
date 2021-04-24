//  
//  UsersListController.swift
//  GitSpace
//
//  Created by Vakhtang Kostava on 22.04.21.
//

import UIKit

class UsersListController: UIViewController {
    
    // MARK: Internal Components
    
    private let searchContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    // TODO: Search icon doesn't look good. FIX IT
    private let searchField: UITextField = {
        let input = UITextField()
        input.translatesAutoresizingMaskIntoConstraints = false
        input.placeholder = "Search"
        input.layer.masksToBounds = true
        input.layer.borderColor = UIColor.black.cgColor
        input.layer.borderWidth = 1.0
        input.layer.cornerRadius = 10
        input.leftViewMode = .always
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        let image = UIImage(named: "search")
        imageView.image = image
        input.leftView = imageView
        return input
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UserNormalCell.self)
        tableView.register(UserNotedCell.self)
        return tableView
    }()

    var presenter: UsersListPresenter!
    
}

// MARK: UIViewController Lifecycle
extension UsersListController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
}

// MARK: Setup
extension UsersListController {
    
    private func setup() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        view.backgroundColor = .white
        navigationController?.setNavigationBarHidden(true, animated: false)
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(searchContainerView)
        searchContainerView.addSubview(searchField)
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            searchContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            searchField.topAnchor.constraint(equalTo: searchContainerView.topAnchor, constant: 8),
            searchField.bottomAnchor.constraint(equalTo: searchContainerView.bottomAnchor, constant: -8),
            searchField.leadingAnchor.constraint(equalTo: searchContainerView.leadingAnchor, constant: 8),
            searchField.trailingAnchor.constraint(equalTo: searchContainerView.trailingAnchor, constant: -8),
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchContainerView.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
}

// MARK: UITableViewDelegate
extension UsersListController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectItem(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let isLastCell = indexPath.row == presenter.tableDataSource.count - 1
        if isLastCell {
            let loader = UIActivityIndicatorView(style: .gray)
            loader.frame = .init(x: .zero, y: .zero, width: tableView.bounds.width, height: 50.0)
            loader.startAnimating()

            tableView.tableFooterView = loader
            tableView.tableFooterView?.isHidden = false
        } else {
            tableView.tableFooterView = nil
            tableView.tableFooterView?.isHidden = true
        }
    }
    
}

// MARK: UITableViewDataSource
extension UsersListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.tableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = presenter.tableDataSource[indexPath.row]
        let dequeued = tableView.dequeueReusableCell(withIdentifier: model.cellIdentifier, for: indexPath)
        let cell = dequeued as! CellViewModel
        cell.configure(with: model)
        
        let isLastCell = indexPath.row == presenter.tableDataSource.count - 1
        if isLastCell {
            presenter.shouldLoadNextPage()
        }
        return dequeued
    }
    
}

extension UsersListController: UsersListView {
    
    func reloadList() {
        tableView.reloadData()
    }
    
}

// MARK: Configurable
extension UsersListController: Configurable {
    
    static func configured() -> UsersListController {
        let vc = UsersListController()
        let configurator = UsersListConfiguratorImpl()
        configurator.configure(vc)
        return vc
    }
    
}

