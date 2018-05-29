//
//  SingletonDataModels.swift
//  WSHelper
//
//  Created by Sogo Computers on 5/10/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import Foundation

class SingletonDataModels{
    
    static var sharedInstance = SingletonDataModels()
    
    let dataModelDidUpdateNotification = "dataModelDidUpdateNotification"
    private init() {}
    
    // We use private(set) access modifier, because we want this property to be read-only. The only way to modify this property is via the requestData() method in DataModel.

    //After we updated the local data, we want to post a Notification. The best way to do this will be using a property observer. Add didSet property observer to data variable:
    

    private (set) var data: String?{
        
        didSet{
            
            // Now we are ready to post a Notification:
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: dataModelDidUpdateNotification), object: nil)
        }
    }
    
    // Once we receive data in requestData, we save it in a local variable:
    func requestData(){
        
        // the data was received and parsed to String
        self.data = "Data from wherever"
    }
}
