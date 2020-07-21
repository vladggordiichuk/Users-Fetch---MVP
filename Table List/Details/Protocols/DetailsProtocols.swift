//
//  DetailsProtocols.swift
//  Table List
//
//  Created by Vlad Gordiichuk on 21.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import UIKit

protocol DetailsWireFrameProtocol: class {
    
    static func createDetailsModule(with user: User) -> UIViewController
}
