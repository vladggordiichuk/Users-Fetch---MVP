//
//  ListProtocols.swift
//  Table List
//
//  Created by Vlad Gordiichuk on 21.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

protocol ListPresenterProtocol: class {
    
    var view: ListViewProtocol? { get set }
    var wireFrame: ListWireFrameProtocol? { get set }
    
    func fetchUserList()
    func showUserDetails(from view: ListViewProtocol, with user: User)
}

protocol ListViewProtocol: class {
    
    var presenter: ListPresenterProtocol? { get set }
    
    func reloadInterface(with users: [User])
}

protocol ListWireFrameProtocol: class {
    
    static func createListModule() -> UIViewController
    
    func presentUserDetailsScreen(from view: ListViewProtocol, with user: User)
}
