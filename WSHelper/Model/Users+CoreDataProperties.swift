//
//  Users+CoreDataProperties.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/5/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var name: String?
    @NSManaged public var avatar: String?
    @NSManaged public var userID: Int16
    @NSManaged public var lastName: String?

}
