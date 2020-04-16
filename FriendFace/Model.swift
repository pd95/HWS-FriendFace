//
//  Model.swift
//  FriendFace
//
//  Created by Philipp on 16.04.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import Foundation
import SwiftUI

class Model: ObservableObject {

    @Published var allUsers = [User]()
    
    init() {
        fetchUsers { (users) in
            self.allUsers = users
        }
    }
    
    func user(for id: UUID) -> User? {
        let user = allUsers.first { $0.id == id }
        if user == nil {
            print("No user found for id \(id)")
        }
        return user
    }
}

