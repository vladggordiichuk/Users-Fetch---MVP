//
//  ListWireFrame.swift
//  Table List
//
//  Created by Vlad Gordiichuk on 21.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

final class ListWireFrame: ListWireFrameProtocol {
    
    static func createListModule() -> UIViewController {
        
        let view = ListView()
        let presenter: ListPresenterProtocol = ListPresenter()
        let wireFrame: ListWireFrameProtocol = ListWireFrame()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.wireFrame = wireFrame
        
        return view
    }
    
    func presentUserDetailsScreen(from view: ListViewProtocol, with user: User) {
        
        guard let sourceView = view as? UIViewController else { return }
        
        let detailsView = DetailsWireFrame.createDetailsModule(with: user)
        sourceView.present(detailsView, animated: true, completion: nil)
    }
}

