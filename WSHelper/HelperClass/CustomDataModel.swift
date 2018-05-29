//
//  CustomDataModel.swift
//  WSHelper
//
//  Created by Sogo Computers on 5/14/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import UIKit

//MARK:  --- Struct
struct Feed: Codable {
    let title: String
    let id: URL
    let copyright: String
    let country: String
    let icon: URL
    let updated: Date
    let results: [FeedItem]
}

struct FeedItem: Codable {
    let artistUrl: URL
    let artistId: String
    let artistName: String
    let artworkUrl100: URL
    let copyright: String
    let id: String
    let name: String
    let releaseDate: Date
    let url: URL
}


struct UserDet: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
    
    struct Address: Codable {
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Coordinates
        
        struct Coordinates: Codable {
            let lat: String
            let lng: String
        }
    }
    struct Company: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
}


struct PagedBreweries : Codable {
    struct Meta : Codable {
        let page: Int
        let totalPages: Int
        let perPage: Int
        let totalRecords: Int
        enum CodingKeys : String, CodingKey {
            case page
            case totalPages = "total_pages"
            case perPage = "per_page"
            case totalRecords = "total_records"
        }
    }
    
    struct Brewery : Codable {
        let id: Int
        let name: String
    }
    
    let meta: Meta
    let breweries: [Brewery]
}

//MARK:  --- Class
class CustomDataModel: NSObject {
    
    //MARK: Call Block Method
    func setRequestContentListLocal(completionHandler:@escaping (_ resultsList: NSArray)-> Void){
        
        let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=10"
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let dataResponse = data, error == nil else {
                print("error=\(String(describing: error))")
                return
            }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with: dataResponse, options: []) as? [String: AnyObject]
                if let resultslist = jsonResponse!["results"] as? [[String:Any]]{
                    completionHandler(resultslist as NSArray)
                }
            } catch let parsingError {
                print("Error", parsingError)
            }
        }
        task.resume()
    }

    //MARK: Through data get the details from server
    func urlContentRequest(){
        
        let sampleDataAddress = "https://jsonplaceholder.typicode.com/users"
        let url = URL(string: sampleDataAddress)!
        let jsonData = try! Data(contentsOf: url)
        print(jsonData)
        let jsonDecoder = JSONDecoder()
        let users = try? jsonDecoder.decode(Array<UserDet>.self, from: jsonData)
        //users?.count
        dump(users?.first)
        
        if let users = users {
            let jsonEncoder = JSONEncoder()
            jsonEncoder.outputFormatting = .prettyPrinted
            if let backToJson = try? jsonEncoder.encode(users) {
                if let jsonString = String(data: backToJson, encoding: .utf8) {
                    print(jsonString)
                }
            }
        }
        
        /*if let json = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
         if let jsonArray = json as? [[String: Any]] {
         let users = jsonArray.flatMap {
         UserDet(from: $0 as! Decoder)
         }
         users.count
         dump(users.first)
         }
         }*/
    }
}

//MARK: Extension

extension String {
    
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

