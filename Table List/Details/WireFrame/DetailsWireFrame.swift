//
//  DetailsWireFrame.swift
//  Table List
//
//  Created by Vlad Gordiichuk on 21.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

final class DetailsWireFrame: DetailsWireFrameProtocol {
    
    static func createDetailsModule(with user: User) -> UIViewController {
        return DetailsView(with: user)
    }
}
