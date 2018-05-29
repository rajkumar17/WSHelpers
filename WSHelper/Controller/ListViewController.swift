//
//  ListViewController.swift
//  WSHelper
//
//  Created by Sogo Computers on 5/14/18.
//  Copyright © 2018 Sogo Computers. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
{

    @IBOutlet weak var tablviewList: UITableView!
    
    private let objCustomDataModels = CustomDataModel()
    let rowHeight = 135.0
    var arraylist:[Any] = []
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tablviewList.rowHeight = UITableViewAutomaticDimension
        tablviewList.estimatedRowHeight = CGFloat(rowHeight)
        
        objCustomDataModels.setRequestContentListLocal(completionHandler: {(resultList: NSArray) in
            self.arraylist = (resultList as? [Any])!
            print("_*_*_*_* arraylist = \(self.arraylist)--**_*_*_*_*__*")
            DispatchQueue.main.async { // Correct
               self.tablviewList.reloadData()
            }
        })
        // Do any additional setup after loading the view.
    }
    
    func getIssueListAndPetitionList(){
        
      
    }
    // MARK: -  TableView Delegate Function
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: IndexPath) -> CGFloat
    {
        return UITableViewAutomaticDimension
    }
    
    private func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: IndexPath) -> CGFloat
    {
        return CGFloat(rowHeight)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arraylist.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomTableViewCell
        
        let listItem = self.arraylist[indexPath.row] as! NSDictionary        
        let font = UIFont(name: "Verdana", size: 14)
        
        let strTitle = listItem["title"] as? String
        let bodyStr = listItem["body"] as? String
        
         let titleHeight = heightForLabel(text:strTitle!, font: font!, width: self.tablviewList.bounds.size.width-10)
        let lblTitleFrame = cell.lblTitle?.frame
        cell.lblTitle?.frame = CGRect(x: (lblTitleFrame?.origin.x)!, y: (lblTitleFrame?.origin.y)!, width: (lblTitleFrame?.size.width)!, height: titleHeight)

        cell.lblTitle?.text = strTitle
        
        let bodyHeight = heightForLabel(text:bodyStr!, font: UIFont(name: "Verdana", size: 12)!, width: self.tablviewList.bounds.size.width-10)
        cell.lblbody?.text = bodyStr
        let lblBodyFrame = cell.lblbody?.frame
        cell.lblbody?.frame = CGRect(x: (lblBodyFrame?.origin.x)!, y: (lblBodyFrame?.origin.y)!, width: (lblBodyFrame?.size.width)!, height: bodyHeight)

        cell.lblStatus?.text = listItem["status"] as? String
        
        return cell
    }
    
    func heightForLabel(text:String, font:UIFont, width:CGFloat) -> CGFloat
    {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    
    // MARK: -
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
