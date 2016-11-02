//
//  DisplayVC.swift
//  billRecorder
//
//  Created by 吴昊 on 21/04/2016.
//  Copyright © 2016 haowu. All rights reserved.
//

import UIKit
import CoreData

class DisplayVC: UIViewController,UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate{
    let cellIdentifier = "displaycell"
    var bills = [Bill]()

    @IBOutlet var billTableView: UITableView!
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        return refreshControl
    }()
    
    var managedObjectContext: NSManagedObjectContext!
    let formatter:NSDateFormatter = NSDateFormatter()
    
    lazy var fetchedResultsController: NSFetchedResultsController = {
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        self.managedObjectContext = appDelegate.managedObjectContext
        let fetchRequest = NSFetchRequest(entityName: "Bill")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchedResultsController.delegate = self
        return fetchedResultsController
    }()
    
    override func viewWillAppear(animated: Bool) {
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        billTableView.delegate = self
        billTableView.dataSource = self
        billTableView.estimatedRowHeight = 100
        billTableView.rowHeight = UITableViewAutomaticDimension
        self.refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        
        self.billTableView.addSubview(self.refreshControl)
        refresh()
        

//        self.view.backgroundColor = UIColor.redColor()

        // Do any additional setup after loading the view.
    }
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
        print("start refresh")
        refreshControl.beginRefreshing()
        refresh()
//        print("%%")
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.billTableView.reloadData()
        })
        print(bills.count)
        
        refreshControl.endRefreshing()
    }
    func refresh(){
        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: "Bill")
        do {
            let billObjects = try context.executeFetchRequest(request) as! [Bill]
            bills = billObjects
//            print(bills.count)
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }
    
    }
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        billTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        billTableView.endUpdates()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = fetchedResultsController.sections {
            print("count")
            print(sections.count)
            return sections.count
        }
        
        return 0
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return bills.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! DisplayView
        setCellInfo(cell, atIndexPath: indexPath)
        return cell

    }
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
            bills.removeAtIndex(indexPath.row)
            self.billTableView.reloadData()
        }
    }
    func setCellInfo(cell: DisplayView, atIndexPath indexPath: NSIndexPath) {
        // Fetch Record
        let record = bills[indexPath.row]

        // Update Cell
        if let amount = record.valueForKey("amount"){
            cell.amountLabel.text = "\(amount)"
        }
        if let type = record.valueForKey("type") {
//            print("\(type)" )
//            if("\(type)" == "0")
            if (type as! NSNumber == 0){
            cell.typeLabel.text = "Income"
            cell.amountLabel.textColor = UIColor.greenColor()}
            else{
            cell.typeLabel.text = "Expenses"
            cell.amountLabel.textColor = UIColor.redColor()}
        }
        if let date = record.valueForKey("date"){
            formatter.dateFormat = "MM-dd"
            let dateString = formatter.stringFromDate(date as! NSDate) as String
            cell.dateLabel.text = dateString
            
        }
        if let category = record.valueForKey("category"){
            
            cell.categoryLabel.text = "\(category)"
        }
        
        
        

    }
    
   

}
