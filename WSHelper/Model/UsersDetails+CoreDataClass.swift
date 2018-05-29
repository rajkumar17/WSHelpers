//
//  UsersDetails+CoreDataClass.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/8/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//
//

import Foundation
import CoreData

@objc(UsersDetails)
public class UsersDetails: NSManagedObject {

    //MARK: -   Get ManagedObjectContext
    class func getContext()-> NSManagedObjectContext{
        let appDelegate = AppDelegate.sharedInstanceAppDelegate()
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: -  Insert UserDetails
    class func insertUserDetails(dictionary: [String:AnyObject])-> NSManagedObject {
        
        let entity = NSEntityDescription.entity(forEntityName: "UserDetails", in: getContext())
        let managedObj = NSManagedObject(entity: entity!, insertInto:getContext())
        managedObj.setValue("Rajkumar", forKey: "name")
        return managedObj
        
    }
    
    // MARK: - Fetch Records
    class func readUserDetails(){
        
        var objUserDetails = [UsersDetails]()
        let context = getContext()
        let fetchrequest = NSFetchRequest<UsersDetails>(entityName: "UserDetails")
        do{
            objUserDetails = try! context.fetch(fetchrequest)
            for usersdets in objUserDetails{
                print("User Details = ", String(describing: usersdets.name) as String)
            }
        }
    }

   /* func createPhotoEntityFrom(dictionary: [String: AnyObject]) -> NSManagedObject? {
        let context = UsersDetails.getContext()
        if let photoEntity = NSEntityDescription.insertNewObject(forEntityName: "Photo", into: context) as? u {
            photoEntity.author = dictionary["author"] as? String
            photoEntity.tags = dictionary["tags"] as? String
            let mediaDictionary = dictionary["media"] as? [String: AnyObject]
            photoEntity.mediaURL = mediaDictionary?["m"] as? String
            return photoEntity
        }
        return nil
    }
    */
}
