//
//  DataModels.swift
//  WSHelper
//
//  Created by Sogo Computers on 5/10/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import Foundation

// MARK: --- PROTOCOLS
protocol DataModelsDelegate: class {
    
    func didRecieveDataUpdate(data: String)
}
//MARK:  --- Struct
struct Address {
    
    let objID: Int?
    var streetAddress: String?
    var city: String?
    let state: String?
    let postalCode: String?
}

struct User {
    
    let objID: Int?
    var firstName: String?
    var lastName: String?
    let age: Int?
    var address = [Address]()
   
}

struct AvatarDetails: Decodable{
    
    let pageNo: Int
    let perPage: Int
    let totalPAges: Int
    let total: Int
    let avatarList: [AvatarItems]
    
    enum codingKeys : String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPage = "total_pages"
    }
}
struct AvatarItems: Decodable{
    
    let firstName: String
    let lastName: String
    let imgUrl: URL
    let indexID: Int
}

// MARK: --- Class
class DataModels{
    
    weak var delegate: DataModelsDelegate?
    // MARK: --- Part 1.5. Callback as a class property
    // Another way of using a callback to communicate with ViewController is to create a callback as a DataModel property:
    var onDataUpdate: ((_ data: String) -> Void)?
    
    // Now, inside the dataRequest method, instead of using a completion handler, we can use this callback:
    func dataRequestCallBlock(){
        let data = "Testing the protocols calling"
        onDataUpdate?(data)
    }
    
    // MARK: --- Using Call Block as completion Handler
    func requestData(completion:((_ data: String) -> Void)){
        let data = "Testing the protocols calling"
        completion(data)
    }
    
    // MARK: ---- Using Protocol
    func requestPostData() -> Void {
        let data = "Testing the protocols calling"
        delegate?.didRecieveDataUpdate(data: data)
    }

    // MARK: --- GET Method
    func requestGetMethod() {
        
        let url = URL(string:"https://reqres.in/api/users?page=2")!
        
        // post the data
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // execute the datatask and validate the result
        let postTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            let responseStatus = response as! HTTPURLResponse
             if responseStatus.statusCode == 200{
        
                if error == nil, let responseResult = (try? JSONSerialization.jsonObject(with: data!, options: [.mutableContainers])) {
                    
                    print("Response Result  == \(responseResult)")
                }
            }
        }
        postTask.resume()
    }
    
    //MARK: --
    
    func setRequestPostData(url: String,completionHandler: @escaping(AvatarDetails?,NSError?)->Void){
        // https://jsonplaceholder.typicode.com/todos/
        let strUrl = URL(string: url)
        
        let request = URLSession.shared.dataTask(with: strUrl!) {
            (data, response, error) in
            
            let httpResponse =  response as! HTTPURLResponse
            if httpResponse.statusCode == 200{
                
                if error == nil, let getResponseData = (try? JSONSerialization.jsonObject(with: data!, options: [.mutableContainers])){
                
                    print("getResponseData == \(getResponseData)")
                }
            }
        }
        request.resume()
    }
   /*
    {
    "id" : 1,
    "first_name": "John",
    "last_name": "Smith",
    "age": 25,
    "address": {
        "id": 1,
        "street_address": "2nd Street",
        "city": "Bakersfield",
        "state": "CA",
        "postal_code": 93309
        }
    
    }
    
    func dfasdf() -> Void {
        
        var user = User()
        var error: NSError?
        var response: AnyObject? = JSONSerialization.JSONObjectWithData(Data, options: JSONSerialization.ReadingOptions())
        
        if let userDict = response as? NSDictionary {
            
            if let addressDict = userDict["address"] as? NSDictionary {
                
                user.address.city = addressDict["city"] as? String
                user.address.streetAddress = addressDict["street_address"] as? String
                //etc, etc
            }
            user.lastName = userDict["first_name"] as? String
            user.lastName = userDict["last_name"] as? String
            //etc, etc
        }
    }*/
    
}
