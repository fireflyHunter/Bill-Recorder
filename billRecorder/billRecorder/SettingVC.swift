//
//  SettingVC.swift
//  billRecorder
//
//  Created by 吴昊 on 22/04/2016.
//  Copyright © 2016 haowu. All rights reserved.
//

import UIKit
import CoreData

class SettingVC: UIViewController {
    let entity = "Bill"
    @IBOutlet var clearButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButton(clearButton)
        

        // Do any additional setup after loading the view.
    }
    func setupButton(button:UIButton){
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0.8
    }
    @IBAction func clickToClear(sender: UIButton) {
        let alertController = UIAlertController(title: "Delete All Data", message: "Are You Sure?", preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(OKAction)
        
        self.presentViewController(alertController, animated: true, completion:nil)

            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            let managedContext = appDelegate.managedObjectContext
            let fetchRequest = NSFetchRequest(entityName: entity)
            fetchRequest.returnsObjectsAsFaults = false
            
            do
            {
                let results = try managedContext.executeFetchRequest(fetchRequest)
                for managedObject in results
                {
                    let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                    managedContext.deleteObject(managedObjectData)
                }
            } catch let error as NSError {
                print("Detele all data in \(entity) error : \(error) \(error.userInfo)")
            }
    }

}
