//
//  ListViewController.swift
//  Table List
//
//  Created by Vlad Gordiichuk on 21.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

final class ListView: UITableViewController {
    
    var presenter: ListPresenterProtocol?
    
    private var users: [User] = []
    
    private var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.translatesAutoresizingMaskIntoConstraints = false
        view.hidesWhenStopped = true
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
        refreshUserData()
    }
    
    private func setUpElements() {
        
        tableView.tableFooterView = UIView()
        
        tableView.addSubview(activityView)
        
        NSLayoutConstraint.activate([
            activityView.centerYAnchor.constraint(equalTo: tableView.centerYAnchor),
            activityView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
    }
    
    private func refreshUserData() {
        
        activityView.startAnimating()
        
        presenter?.fetchUserList()
    }
}

extension ListView: ListViewProtocol {
    
    func reloadInterface(with users: [User]) {

        DispatchQueue.main.async { [weak self] in
            
            self?.users = users
            
            self?.activityView.stopAnimating()
            
            self?.tableView.beginUpdates()
            self?.tableView.insertRows(at: (0 ..< users.count).map({ IndexPath(row: $0, section: 0) }), with: .automatic)
            self?.tableView.endUpdates()
        }
    }
}

extension ListView {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = users[indexPath.row].firstName + " " + users[indexPath.row].lastName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        presenter?.showUserDetails(from: self, with: users[indexPath.row])
    }
}
