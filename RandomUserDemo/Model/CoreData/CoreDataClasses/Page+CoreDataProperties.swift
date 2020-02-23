//
//  Page+CoreDataProperties.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 23/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//
//

import Foundation
import CoreData


extension Page {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Page> {
        return NSFetchRequest<Page>(entityName: "Page")
    }

    @NSManaged public var page: Int16
    @NSManaged public var seed: String?
    @NSManaged public var results: Int16
    @NSManaged public var version: String?
    @NSManaged public var userResults: NSSet?

}

// MARK: Generated accessors for userResults
extension Page {

    @objc(addUserResultsObject:)
    @NSManaged public func addToUserResults(_ value: User)

    @objc(removeUserResultsObject:)
    @NSManaged public func removeFromUserResults(_ value: User)

    @objc(addUserResults:)
    @NSManaged public func addToUserResults(_ values: NSSet)

    @objc(removeUserResults:)
    @NSManaged public func removeFromUserResults(_ values: NSSet)

}
