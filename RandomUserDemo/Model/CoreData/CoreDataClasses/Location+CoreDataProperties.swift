//
//  Location+CoreDataProperties.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 23/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//
//

import Foundation
import CoreData


extension Location {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
        return NSFetchRequest<Location>(entityName: "Location")
    }

    @NSManaged public var city: String?
    @NSManaged public var state: String?
    @NSManaged public var postcode: String?
    @NSManaged public var street: Street?
    @NSManaged public var coordinates: Coordinates?
    @NSManaged public var timezone: Timezone?
    @NSManaged public var user: User?

}
