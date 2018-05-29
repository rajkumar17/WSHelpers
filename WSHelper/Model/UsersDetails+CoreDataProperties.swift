//
//  UsersDetails+CoreDataProperties.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/8/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//
//

import Foundation
import CoreData


extension UsersDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UsersDetails> {
        return NSFetchRequest<UsersDetails>(entityName: "UsersDetails")
    }

    @NSManaged public var dateOfBirth: NSDate?
    @NSManaged public var emailId: String?
    @NSManaged public var name: String?
    @NSManaged public var numberOfChildren: Int16
    @NSManaged public var cars: Cars?

}
