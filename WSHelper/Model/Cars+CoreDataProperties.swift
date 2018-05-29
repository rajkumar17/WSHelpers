//
//  Cars+CoreDataProperties.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/8/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//
//

import Foundation
import CoreData


extension Cars {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cars> {
        return NSFetchRequest<Cars>(entityName: "Cars")
    }

    @NSManaged public var model: String?
    @NSManaged public var year: Int16
    @NSManaged public var usersdetails: NSSet?

}

// MARK: Generated accessors for usersdetails
extension Cars {

    @objc(addUsersdetailsObject:)
    @NSManaged public func addToUsersdetails(_ value: UsersDetails)

    @objc(removeUsersdetailsObject:)
    @NSManaged public func removeFromUsersdetails(_ value: UsersDetails)

    @objc(addUsersdetails:)
    @NSManaged public func addToUsersdetails(_ values: NSSet)

    @objc(removeUsersdetails:)
    @NSManaged public func removeFromUsersdetails(_ values: NSSet)

}
