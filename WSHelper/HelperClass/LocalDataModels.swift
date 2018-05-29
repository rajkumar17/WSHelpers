//
//  LocalDataModels.swift
//  WSHelper
//
//  Created by Sogo Computers on 5/14/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import UIKit

class LocalDataModels: NSObject {

    //MARK: -- LOCAL File JSON Complex Parser
    func readDatasFromLocalFile(){
        
        do {
            if let file = Bundle.main.url(forResource: "set4", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
                print("jsonResult = \(jsonResult)")
                
                getParserData(result: jsonResult as! NSDictionary)
                
                if let object = jsonResult as? [String: AnyObject] {
                    
                   /* let definitionlist = object["definition"] as? [[String: Any]]
                    // json is a dictionary
                    print("object is definitionlist = \(String(describing: definitionlist))")
                    for testvalue in definitionlist!{
                        //print("workProduct =\(String(describing: testvalue["workProduct"]as?[Any]))")
                        if let workproductlist = testvalue["workProduct"] as? [[String:Any]]{
                             print("workproductlist =\(String(describing: workproductlist))")
                            for testvalue2 in workproductlist{
                                //print("testvalue2 =\(String(describing:  testvalue2["task"]as?[Any]))")
                                if let tasklist = testvalue2["task"] as? [[String:Any]]{
                                    print("tasklist =\(String(describing: tasklist))")
                                    for resourcelist in tasklist{
                                         print("resourcelist =\(String(describing: resourcelist))")
                                        if let resources = resourcelist["resources"] as? [[String:Any]]
                                        {
                                            print("resources =\(String(describing: resources))")
                                        }
                                        if let resources = resourcelist["teamCode"] as? [Any]
                                        {
                                            print("teamCode =\(String(describing: resources))")
                                        }
                                    }
                                }
                            }
                        }
                    }*/
                } else if let object = jsonResult as? [Any] {
                    // json is an array
                    print("object is Any = \(object)")
                    
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getParserData(result : NSDictionary){
        
        
        // first Dictionary or response from server
        let dicResult = result
        
        // First step in parsing:
        let projectId = dicResult.value(forKey: "Project") as! Int
        print ("projectId = \(projectId)")
        let definitions = dicResult.object(forKey: "definition") as? NSArray
        print ("definitions = \(String(describing: definitions))")
        //loop work
    
        if(definitions != nil){
            for items in definitions!
            {
                //============ or ==========
                for (key, value) in items as! [String:Any]
              {
                print ("items \((key, value))")
            
                //============ or ==========
                switch (key)
                {
                case "entryID":
                    print(value)
                    break
                case "statusCode":
                    print(value)
                    break
                case "validationCode":
                    print(value)
                    break
                case "workProduct":
                    let workproducts = value as? NSArray
                    //loop work
                    if(workproducts != nil){
                        
                        /*for (key1, value1) in workproducts as? Array<Any>
                        {
                            
                            print ("items1 =\((key1, value1))")
                            switch (key1){
                            case "task":
                                
                                let tasks = value1 as? NSDictionary
                                let desc = tasks?.value(forKey: "desc") as! String
                                let hours = tasks?.value(forKey: "hours") as! Int
                                let week = tasks?.value(forKey: "week") as! Int
                                let resources = tasks?.value(forKey: "resources") as! NSArray
                                for item in resources{
                                    
                                    let r = (item as AnyObject).value(forKey: "r") as! String
                                    let l = (item as AnyObject).value(forKey: "l") as! String
                                    let s = (item as AnyObject).value(forKey: "s") as! String
                                    
                                    //============ or ==========
                                    
                                    for (key1, value1) in (item as? [String:AnyObject])!
                                    {
                                        
                                        print ("items2 =\((key1, value1))")
                                        
                                    }
                                }
                                
                                let managerCode = tasks?.value(forKey: "managerCode") as! Int
                                let teamCodes = tasks?.value(forKey: "teamCode") as! NSArray
                                if(teamCodes.count>0){
                                    
                                    let teamCode = teamCodes[0]
                                }
                                break
                                
                            case "scope":
                                
                                print(value1)
                                break
                                
                            default:
                                break
                            }
                        }*/
                        
                    }
                    break
                default:
                    break
                }
               }
            }
        }
    }
}
