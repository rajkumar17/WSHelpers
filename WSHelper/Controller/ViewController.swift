//
//  ViewController.swift
//  WSHelper
//
//  Created by Sogo Computers on 4/5/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import UIKit
import CoreData
//import Firebase

//MARK: -- Class
class ViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {

    var imageView1: UIImageView!
    @IBOutlet weak var tableviewList: UITableView!
    
    private let dataModel = DataModels()
    private let customJsonParser = CustomJsonParser()
    private let objCustomDataModel = CustomDataModel()
    private let objLocalDataModel = LocalDataModels()
    
    
    var arrayAvatarList:[Any] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getDataUpdate), name: NSNotification.Name(rawValue: "dataModelDidUpdateNotification"), object: nil)

        // To use this callback in ViewController class, we simply assign an appropriate method to it (again using weak self):
        
        // MARK: -- Following methods called from other class parser
    
        //customJsonParser.jsonParsewithInitDictionary()
        //customJsonParser.jsonparserWithCodable()
        //customJsonParser.jsonparserWithComplexJSON()
        
       //urlContentRequest()

        //MARK: -- Completion Block function called here
//        dataModel.requestData(completion: {(data: String) in
//            self.useData(data: data)
//        })

        //MARK: -- For Protocols
        //dataModel.delegate=self
        //dataModel.requestPostData()
        //dataModel.requestGetMethod()
        
        //requestMultiForm()
        
        
        //MARK -- Read Local files from resouces
        objLocalDataModel.readDatasFromLocalFile()
        
        // Do any additional setup after loading the view, typically from a nib.
        /*Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
            AnalyticsParameterItemID: "id-\(title!)",
            AnalyticsParameterItemName: title!,
            AnalyticsParameterContentType: "cont"
        ])*/
        
    }
    override func viewWillAppear(_ animated: Bool) {
        // API Request
        // getAvatorList()
        
    }
    //MARK: -- Notification Using
    @objc func getDataUpdate(){
        
        if let dataModel = SingletonDataModels.sharedInstance.data{
            print("getDataUpdate \(dataModel)")
            
        }
    }
  
    private func useData(data: String){
        print("useData \(data)")
    }
   
    //MARK: -- function
    
    func getAvatorList(){
        
        WSHelpers.requestGetMethod(completionHandler: {(responseArray: NSArray) in
            self.arrayAvatarList = responseArray as! [Any]
            print("self.arrayAvatarList \(self.arrayAvatarList)")
            DispatchQueue.main.async {
                self.tableviewList.reloadData()
            }
        })
        
    }
    // MARK:  --- Core DATA
    func insertDataInUsers(){
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userEntity = NSEntityDescription.entity(forEntityName: "UsersDetails", in: managedContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue("John", forKeyPath: "name")
        user.setValue("john@test.com", forKey: "emailId")
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: "1990/10/08")
        user.setValue(date, forKey: "dateOfBirth")
        user.setValue(0, forKey: "numberOfChildren")

        
        let carEntity = NSEntityDescription.entity(forEntityName: "Cars", in: managedContext)!
        let car1 = NSManagedObject(entity: carEntity, insertInto: managedContext)
        car1.setValue("Audi TT", forKey: "model")
        car1.setValue(2010, forKey: "year")
        car1.setValue(user, forKey: "usersdetails")
        
        let car2 = NSManagedObject(entity: carEntity, insertInto: managedContext)
        car2.setValue("BMW X6", forKey: "model")
        car2.setValue(2014, forKey: "year")
        car2.setValue(user, forKey: "usersdetails")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        print("Insert completed")
        readDataFromUsers()
    }
    
    func readDataFromUsers(){
        
        print("Reads Start")
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UsersDetails")
        userFetch.fetchLimit = 1
        userFetch.predicate = NSPredicate(format: "name = %@", "John")
        userFetch.sortDescriptors = [NSSortDescriptor.init(key: "emailId", ascending: true)]
        let users = try! managedContext.fetch(userFetch)
        let john: UsersDetails = users.first as! UsersDetails
        print("Email: \(String(describing: john.emailId))")
        let johnCars = john.cars?.usersdetails?.allObjects as! [Cars]
        print("has \(johnCars.count)")
        
        
    }

    //MARK: --- TableView Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayAvatarList.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellAvator", for: indexPath) as! CustomAvatarCell
        
        let avatorlist = self.arrayAvatarList[indexPath.row] as? NSDictionary
        print("avatorlist \(String(describing: avatorlist))")
        
        let imageLink = URL(string:(avatorlist?.value(forKey: "avatar") as? String)!)
        cell.imageViewProfile?.downloadedFrom(url: imageLink!)
        cell.lblFirstName?.text = avatorlist?.value(forKey: "first_name") as? String
        cell.lblLastName?.text =  avatorlist?.value(forKey: "last_name") as? String
        return cell
    }
    // MARK:  --- Core DATA
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: METHOD ------ POST NSURLSession: dataTaskWithUrl example
    // Let's start this example  with the dataTaskWithUrl function.
}

// MARK: -- Extension
extension UIImageView {
    
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}
extension UIViewController: DataModelsDelegate{
    
    func didRecieveDataUpdate(data: String) {
        print("didRecieveDataUpdate \(data)")
    }
}
