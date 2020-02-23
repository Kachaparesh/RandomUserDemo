//
//  DateOfBirth+CoreDataProperties.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 23/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//
//

import Foundation
import CoreData


extension DateOfBirth {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DateOfBirth> {
        return NSFetchRequest<DateOfBirth>(entityName: "DateOfBirth")
    }

    @NSManaged public var age: Int16
    @NSManaged public var date: Date?
    @NSManaged public var user: User?

}
