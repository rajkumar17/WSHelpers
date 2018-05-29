//
//  Country+CoreDataProperties.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/5/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//
//

import Foundation
import CoreData


extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var name: String?
    @NSManaged public var alphaCode2: String?
    @NSManaged public var alphaCode3: String?

}
