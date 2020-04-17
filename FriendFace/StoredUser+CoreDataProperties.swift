//
//  StoredUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Philipp on 17.04.20.
//  Copyright © 2020 Philipp. All rights reserved.
//
//

import Foundation
import CoreData


extension StoredUser: Identifiable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoredUser> {
        return NSFetchRequest<StoredUser>(entityName: "StoredUser")
    }

    @NSManaged public var name: String
    @NSManaged public var age: Int16
    @NSManaged public var company: String
    @NSManaged public var email: String
    @NSManaged public var about: String
    @NSManaged public var id: UUID
    @NSManaged public var friend: NSSet?

    public var friends: [StoredUser] {
        let set = friend as? Set<StoredUser> ?? []
        return set.sorted { $0.name < $1.name }
    }
    
    func populate(from user: User) {
        self.name = user.name
        self.age = Int16(user.age)
        self.company = user.company
        self.email = user.email
        self.about = user.about
        self.id = user.id
    }
}

// MARK: Generated accessors for friends
extension StoredUser {

    @objc(addFriendObject:)
    @NSManaged public func addToFriend(_ value: StoredUser)

    @objc(removeFriendObject:)
    @NSManaged public func removeFromFriend(_ value: StoredUser)

    @objc(addFriend:)
    @NSManaged public func addToFriend(_ values: NSSet)

    @objc(removeFriend:)
    @NSManaged public func removeFromFriend(_ values: NSSet)

}
