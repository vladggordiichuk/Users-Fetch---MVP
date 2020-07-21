//
//  User.swift
//  Table List
//
//  Created by Vlad Gordiichuk on 21.07.2020.
//  Copyright © 2020 Vlad Gordiichuk. All rights reserved.
//

import Foundation

struct User: Decodable {
    
    let id: Int
    let firstName: String
    let lastName: String
    let email: String
    let avatar: URL?
    
    init(id: Int, firstName: String, lastName: String, email: String, avatar: URL?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.avatar = avatar
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, avatar
    }
    
    init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        firstName = try container.decode(String.self, forKey: .firstName)
        lastName = try container.decode(String.self, forKey: .lastName)
        email = try container.decode(String.self, forKey: .email)
        
        if
            let urlString = try? container.decode(String.self, forKey: .avatar),
            let url = URL(string: urlString) {
            avatar = url
        } else { avatar = nil }
    }
}
