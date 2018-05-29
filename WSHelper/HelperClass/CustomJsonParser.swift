//
//  JsonParser.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/6/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import Foundation

/*[
    {
        "userId": 1,
        "id": 1,
        "title": "delectus aut autem",
        "completed": false
    },
    {
        "userId": 1,
        "id": 2,
        "title": "quis ut nam facilis et officia qui",
        "completed": false
    }
]*/

// MARK: -- Struct with Init JSON Dictionary
struct UserModel {
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
    
    init(_ dictionary: [String: Any]) {
        self.userId = dictionary["userId"] as? Int ?? 0
        self.id = dictionary["id"] as? Int ?? 0
        self.title = dictionary["title"] as? String ?? ""
        self.completed = dictionary["completed"] as? Bool ?? false
    }
}

// MARK: -- Struct with Codable Protocol

//  This is the new protocol introduced by Apple in Swift 4 can provide Encodable and Decodable built-in feature. It will make JSON parsing easier. It can convert itself into and out of an external representation.

//  Codable model looks like this. Its pretty easy to understand in a very less code we can manage it.

//  This is the codable model sample I showed you here. You need to make your own structure model based on your JSON response.

struct UserCodable: Codable{
    var userId: Int
    var id: Int
    var title: String
    var completed: Bool
}
// MARK: -- Struct with Complex JSON Parsing with Codable Protocol
/*
{
    "branch": {
        "subject": 5,
        "total_students": 110,
        "total_books": 150
    },
    "Subject": [
        {
        "subject_id": 301,
        "name": "EMT",
        "pratical": false,
        "pratical_days": [
            "Monday",
            "Friday"
        ]
      },
      {
        "subject_id": 302,
        "name": "Network Analysis",
        "pratical": true,
        "pratical_days": [
            "Tuesday",
            "Thursday"
          ]
       }
    ]
}*/


struct Students : Codable // Main Dictionary
{
    
    struct Branch : Codable // Main Sub - Dictionary and Enum with his Keys
    {
        let subject: Int
        let totalStudents: Int
        let totalBooks: Int
        
        private enum CodingKeys : String, CodingKey {
            case subject
            case totalStudents = "total_students"
            case totalBooks = "total_books"
        }
    }
    struct Subject : Codable // Main Sub - Dictionary
    {
        let subject_id: Int
        let name: String
        let pratical: Bool
        let pratical_days: [String]  // Sub - Dictionary inside the Array list
    }
    
    let branchDet: Branch
    let subjectDet: [Subject]
}
//  MARK: --
class CustomJsonParser{
    
    class func insertItem(reponse: NSDictionary) {
     let appDelegate = AppDelegate.sharedInstanceAppDelegate()
      appDelegate.saveContext()
    }
    
    //MARK:  -- Simple Struct with Dictionary Parsing
    func jsonParsewithInitDictionary(){
     
        print("jsonParsewithInitDictionary")
        
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/todos") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                print("jsonParsewithInitDictionary jsonResponse = \(jsonResponse)") //Response result
                
                //here dataResponse received from a network request
                guard let jsonArray = jsonResponse as? [[String: Any]] else {
                    return
                }
                print("jsonArray =  \(jsonArray)")
                //Now get title value
                guard let title = jsonArray[0]["title"] as? String else { return }
                print(title) // delectus aut autem
                
                for dic in jsonArray{
                    guard let title = dic["title"] as? String else { return }
                    print(title) //Output
                }
                
                var model = [UserModel]() //Initialising Model Array
                for dic in jsonArray{
                    model.append(UserModel(dic)) // adding now value in Model array
                }
                print(model[0].userId) // 1211
                
                //Cool 😎 , Now you know something about JOSN parsing right ? 😃
                //Let’s make this same code more swifty with FlatMap -
                
                model = jsonArray.flatMap{ (dictionary) in
                    return UserModel(dictionary)
                }
                print(model[0].userId)
                //make more simple
                model = jsonArray.flatMap{ return UserModel($0)}
                //One more time
                model = jsonArray.flatMap{UserModel($0)}
                //Or
                model = jsonArray.flatMap(UserModel.init)
                //Output
                print(model[0].userId) // 1211
                //Yeah 👍, Lets do more something.
                
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()

    }
    
    //MARK: -- Struct with Codable the JSON Data
    func jsonparserWithCodable(){
    
        print("jsonparserWithCodable")
        /*
         Why I have used model [User].self because we are getting the response in Array format if your response will get in Dictionary only then
        Output from network request —
        {
            "userId": 1,
            "id": 1,
            "title": "delectus aut autem",
            "completed": false
        }
        
        We need to use our model class like User.self for Dictionary response -
        
        do {
            //here dataResponse received from a network request
            let decoder = JSONDecoder()
            let model = try decoder.decode(User.self, from:
                dataResponse) //Decode JSON Response Data
            print(model.userId) //Output - 1221
        } catch let parsingError {
            print("Error", parsingError)
        }
        Custom key names
        We can modify our codable key with custom String keys but it supposes to match with your JSON response keys. Otherwise you will get error message -
            
            
        Error Message in bottom
        Adding custom keys for Codable model -
        
        struct User: Codable{
            var userId: Int
            var id: Int
            var title: String
            var completed: Bool
            //Custom Keys
            enum CodingKeys: String, CodingKey {
                case userId
                case id = "serviceId"  //Custom keys
                case title = "titleKey" //Custom keys
                case completed
            }
        }
        */
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/todos") else {return}
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
                }
            do {
                
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: [])
                print("jsonparserWithCodable jsonResponse = \(jsonResponse)") //Response result
                
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode([UserCodable].self, from:dataResponse) //Decode JSON Response Data
                print("jsonparserWithCodable model\(model)")
                //print(model) //Output - 1221

            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    // MARK: -- Struct with Complex JSON
    func jsonparserWithComplexJSON(){
        
        print("jsonparserWithComplexJSON")
        //Complex JSON Parsing with Codable Protocol
        //Now we having complex JSON which having Dictionary, Array
        
        guard let url = URL(string:"https://jsonplaceholder.typicode.com/todos") else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return
            }
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? [Any]
                print("jsonparserWithComplexJSON jsonResponse = \(String(describing: jsonResponse))") //Response result
                
                // data we are getting from network request
                let decoder = JSONDecoder()
                let response = try decoder.decode([Students].self, from: dataResponse)
                print("jsonparserWithComplexJSON response\(response)")
                //print("jsonparserWithComplexJSON \(response.subjectDet[0].name)") //Output - EMT
                
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }
    
    //MARK: ---
  
}
