//
//  ViewController.swift
//  DoubanJSON
//
//  Created by Noirozr on 15/6/29.
//  Copyright (c) 2015年 Yongjia Liu. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate{

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var textfield: UITextField!
    
    var titleTableView: UITableView!
    var itemArr: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTableView = UITableView(frame: CGRectMake(0, 200, self.view.frame.size.width, 400))
        titleTableView.delegate = self
        titleTableView.dataSource = self
        titleTableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        //titleTableView.estimatedRowHeight = 30
        self.view.addSubview(titleTableView)
        
        itemArr = []
        let str = "https://api.douban.com/v2/book/search?q=python&fields=id,title"
        getSiteData(str)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    @IBAction func getData(sender: AnyObject) {
        
        let str = "https://api.douban.com/v2/book/search?q=\(textfield.text)&fields=id,title".stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        getSiteData(str!)
        
        
    }
    
    func getSiteData(urlString: String) {
        
        let url = NSURL(string: urlString)
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "GET"
    
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {(data, response, error) in
            
            dispatch_async(dispatch_get_main_queue(), {
                self.itemArr = []
                self.updateWithData(data)
                self.titleTableView.reloadData()
            })
            
        }
        
        task.resume()
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.textfield.resignFirstResponder()
        return true
    }
    
    func updateWithData(data: NSData) {
        
        var jsonError: NSError?
        let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
        if let count = json["count"] as? Int {
            label1.text = "\(count)"
            
            if let books = json["books"] as? NSArray {
                
                for i in 0..<count {
                    if let book = books[i] as? NSDictionary {
                        if let title = book["title"] as? String {
                            itemArr.append(title)
                            println(title)
                        }
                    }
                }
                
                
            } else {
                println("no books")
            }
            
            
            
        } else {
            println("no object")
        }
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = itemArr[indexPath.row]
        return cell
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArr.count
    }
    
    
}

