//
//  WSHeplers.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/6/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import Foundation

/*
 {
 avatar = "https://s3.amazonaws.com/uifaces/faces/twitter/marcoramires/128.jpg";
 "first_name" = Eve;
 id = 4;
 "last_name" = Holt;
 }
 */
//
//struct AvatarDetails: Decodable{
//    
//    let totalPages: Int
//    let pageNo: Int
//    let perPage: Int
//    let total: Int
//}

/*
 
 if let JSON = response.result.value as? [String:Any] {
 if let response = JSON["wsResponse"] as? [String:Any],
 let aarti = response["aarti"] as? [[String:Any]] {
    for item in aarti {
        let content = item["content"] as! String
        let identifier = item["identifier"] as! String
        let title = item["title"] as! Int
        let type = item["type"] as! String
        print(content, identifier, title, type)
    }
  }
 }
 */

//MARK: -- Class

class WSHelpers: NSObject{

    var AvatarDets = [AvatarDetails]()
    
    //MARK: -- Multipart URLSession Request
    func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string: "http://www.swiftdeveloperblog.com/http-post-example-script/");
        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
        
        let request = NSMutableURLRequest(url: myUrl! as URL);
        request.httpMethod = "POST";
        //let param:[String: String] = ["username"  : "+919686765861","password" : "costBo5$"]        
        let boundary = "Boundary-\(UUID().uuidString)"
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
    
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            // You can print out response object
            print("******* response = \(String(describing: response))")
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                print(json ?? "")
                
            }catch
            {
                print(error)
            }
        }
        task.resume()
    }
    
    // MARK: --- GET Method -- Work
    class func requestGetMethod(completionHandler:@escaping (_ data: NSArray)->Void) {
        let url = URL(string:"https://reqres.in/api/users?page=2")!
        
        // post the data
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // execute the datatask and validate the result
        let postTask = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            
            if error == nil, let userObject = (try? JSONSerialization.jsonObject(with: data!, options: [])) {
                print("Response data userObject  == \(userObject)")
                print("-**_*_*_*_*_*_*_*_*_*_*_*_*")
                // you've got the jsonObject
                let responseStatus = response as! HTTPURLResponse
                if responseStatus.statusCode == 200{
                    let responseResult = try? JSONSerialization.jsonObject(with: data!, options: [.mutableContainers]) //as? [String: Any]
                    
                    if let dataArray = responseResult as? [String: Any]
                    {
                        let response_data = dataArray["data"] as? [[String:Any]]
                        completionHandler(response_data! as NSArray)
                        
//                            for items in response_data{
//                                print("firstname =\(String(describing: items["first_name"]as String))")
//                            }
                        //}
                        
                        /*if let pageNo = dataArray["page"]as? Int{
                            print("Get page = \(String(describing: pageNo))")
                        }
                        if let pagePer = dataArray["per_page"]as? Int{
                            print("Get pagePer = \(String(describing: pagePer))")
                        }
                        if let totals = dataArray["total"]as? Int{
                            print("Get totals = \(String(describing: totals))")
                        }
                        if let totalPages = dataArray["total_pages"]as? Int{
                            print("Get totalPages = \(String(describing: totalPages))")
                        }
                        print("-**_*_*_*_*_*_*_*_*_*_*_*_*")
                    
                        if let response_data = dataArray["data"] as? [[String:Any]]
                        {
                            for items in response_data{
                                print("firstname =\(String(describing: items["first_name"]as? String))")
                            }
                        }*/
                    }
                }
            }
        }
        postTask.resume()
    }
    
    //MARK: -- URLSession GET Method
    func requestGetMethod(){
        
        let url = "https://restcountries.eu/rest/v2/all"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration, delegate: self as? URLSessionDelegate , delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request){
            (data, response, error) in
            if (error != nil){
                print("Error")
            }else{
                do{
                    let fetchedData = try JSONSerialization.jsonObject(with:data!, options: .allowFragments) as? [String:AnyObject]
                    print(fetchedData!)
                    
                }catch{
                    print("catch error")
                }
            }
        }
        task.resume()
    }
    
    // MARK: --- POST Method with Autho
    func requestPOSTMethod()-> Void{
        
        let urlLink = URL(string:"https://reqres.in/api/users?")!
        let request = NSMutableURLRequest(url: urlLink)
        request.httpMethod = "POST"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let postData = "name=morpheus&job=leader"
        let httpData = try? JSONSerialization.data(withJSONObject: postData, options: [])
        request.httpBody = httpData
        let taskRequest = URLSession.shared.dataTask(with: request as URLRequest){
            (data, response, error) in
            guard let _: Data = data, let _ :URLResponse = response, error == nil else{
                print("---  Error Occured in request")
                return
            }
            let urlResponse = response as! HTTPURLResponse
            if urlResponse.statusCode == 200{
                print("Response JSON DATA = \(response.debugDescription)")
                let responseResult = try? JSONSerialization.jsonObject(with: data!, options: [])
                print("responseResult \(String(describing: responseResult))")
                if let dataArray = responseResult as? [String:Any]{
                    print("dataArray \(dataArray)")
                    if let dataList = dataArray["data"] as? [Any]{
                        print("dataList \(dataList)")
                        for value in dataList{
                            print("Data List Item \(value)")
                        }
                    }
                }
            }
        }
        taskRequest.resume()
    }
    
    
    func dataRequest() {
        
        // https://jsonplaceholder.typicode.com
        // http://services.groupkt.com/country/search?
        //
        let urlToRequest = "http://services.groupkt.com/country/search?"
        let url4 = URL(string: urlToRequest)!
        let session4 = URLSession.shared
        let request = NSMutableURLRequest(url: url4)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        let paramString = "text=un"
        request.httpBody = paramString.data(using: String.Encoding.utf8)
        let task = session4.dataTask(with: request as URLRequest) {
            (data, response, error) in
            guard let _: Data = data, let _: URLResponse = response, error == nil else {
                print("*****error")
                return
            }
            print("response \(String(describing: response))")
            let dataString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("*****This is the data 4: \(String(describing: dataString))") //JSONSerialization
        }
        task.resume()
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
