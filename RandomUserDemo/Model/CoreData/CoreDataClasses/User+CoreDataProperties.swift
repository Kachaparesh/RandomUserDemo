//
//  User+CoreDataProperties.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 23/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var gender: String?
    @NSManaged public var email: String?
    @NSManaged public var nat: String?
    @NSManaged public var phone: String?
    @NSManaged public var cell: String?
    @NSManaged public var name: Name?
    @NSManaged public var location: Location?
    @NSManaged public var login: Login?
    @NSManaged public var dateOfBirth: DateOfBirth?
    @NSManaged public var registered: RegisteredDate?
    @NSManaged public var id: Id?
    @NSManaged public var picture: Picture?
    @NSManaged public var page: Page?

}
