//
//  Street+CoreDataProperties.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 23/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//
//

import Foundation
import CoreData


extension Street {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Street> {
        return NSFetchRequest<Street>(entityName: "Street")
    }

    @NSManaged public var number: Int16
    @NSManaged public var name: String?
    @NSManaged public var location: Location?

}
