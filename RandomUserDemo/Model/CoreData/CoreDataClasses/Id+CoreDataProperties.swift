//
//  Id+CoreDataProperties.swift
//  RandomUserDemo
//
//  Created by Paresh Kacha on 23/02/20.
//  Copyright © 2020 Paresh Kacha. All rights reserved.
//
//

import Foundation
import CoreData


extension Id {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Id> {
        return NSFetchRequest<Id>(entityName: "Id")
    }

    @NSManaged public var name: String?
    @NSManaged public var value: String?
    @NSManaged public var user: User?

}
