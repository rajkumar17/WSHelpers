//
//  Pages+CoreDataProperties.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/5/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//
//

import Foundation
import CoreData


extension Pages {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pages> {
        return NSFetchRequest<Pages>(entityName: "Pages")
    }

    @NSManaged public var pageNo: Int16
    @NSManaged public var total: Int16
    @NSManaged public var totalPages: Int16
    @NSManaged public var userId: Int16
    @NSManaged public var operPage: Int16

}
