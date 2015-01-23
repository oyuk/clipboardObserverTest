//
//  ViewController.swift
//  clipboardObserverTest
//
//  Created by oky on 2015/01/23.
//  Copyright (c) 2015年 oky. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource ,StringsDelegate{

    
    var tableView:UITableView?
    let strings = Strings.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView = UITableView(frame: self.view.bounds)
        tableView?.dataSource = self
        strings.stringsDelegate = self
        self.view.addSubview(tableView!)
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reloadTableViewData() {
        tableView?.reloadData()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return strings.getArray().count
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = strings.getArray()[indexPath.row]
        return cell
    }

}

