//
//  Model.swift
//  FriendFace
//
//  Created by Philipp on 16.04.20.
//  Copyright © 2020 Philipp. All rights reserved.
//

import Foundation
import SwiftUI
import CoreData

class Model: ObservableObject {
    
    let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        
        let request: NSFetchRequest<StoredUser> = StoredUser.fetchRequest()
        let count = (try? context.fetch(request).count) ?? 0
        
        print("\(count) users in CoreData database")
        if count == 0 {
            fetchUsers(completion: { users in
                print("Importing \(users.count) users into CoreData")
                var storedUserDict = [UUID: StoredUser]()

                // Create all stored users
                users.forEach { user in
                    let storedUser = storedUserDict[user.id] ?? StoredUser(context: context)
                    storedUserDict[user.id] = storedUser

                    storedUser.populate(from: user)
                    
                    user.friends.forEach { friend in
                        let storedFriend = storedUserDict[friend.id] ?? StoredUser(context: context)
                        storedUserDict[friend.id] = storedFriend

                        storedFriend.id = friend.id
                        storedUser.addToFriend(storedFriend)
                    }
                }
                try? context.save()
            })
        }
    }
}

