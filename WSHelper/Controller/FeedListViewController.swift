//
//  FeedListViewController.swift
//  WSHelper
//
//  Created by Sogo Computers on 5/14/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import UIKit


class FeedListViewController: UIViewController {

    var feed: Feed?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //   https://www.quickbytes.io/tutorials/introduction-to-json-and-codable-in-swift-4
        //  https://github.com/quickbytesio/base-project-swift
        
        self.view.backgroundColor = UIColor.lightGray
        
        // http://roadfiresoftware.com/feed/json
        // https://rss.itunes.apple.com/api/v1/us/ios-apps/new-apps-we-love/all/25/non-explicit.json
        
        let url = URL(string: "http://roadfiresoftware.com/feed/json")
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else {
                print("Error: \(String(describing: error))")
                return
            }
            
            if let appsList = String.init(data: data, encoding: String.Encoding.utf8) { // 6
                print(appsList) // 7
            }
//            let feedWrapper = try! self.decoder.decode([String: Feed].self, from: data)
//            let feed = feedWrapper["feed"]!
            
            //print("\(feed)")
        }
        
        task.resume()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
