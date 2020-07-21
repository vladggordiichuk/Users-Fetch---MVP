//
//  ListPresenter.swift
//  Table List
//
//  Created by Vlad Gordiichuk on 21.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

final class ListPresenter: ListPresenterProtocol {
    
    weak var view: ListViewProtocol?
    var wireFrame: ListWireFrameProtocol?
    
    func fetchUserList() {
        
        NetworkManager.performRequest(to: EndpointCollection.getUsers, with: FetchUserListRequest(page: 2)) { [weak self] (result: Result<FetchUserListResponse>) in

            switch result {
            case .success(let response): self?.view?.reloadInterface(with: response.data)
            case .failure(_): self?.fetchUserList()
            }
        }
    }
    
    func showUserDetails(from view: ListViewProtocol, with user: User) {
        wireFrame?.presentUserDetailsScreen(from: view, with: user)
    }
}
