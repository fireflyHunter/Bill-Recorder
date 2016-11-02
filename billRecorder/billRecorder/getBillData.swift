//
//  getBillData.swift
//  billRecorder
//
//  Created by 吴昊 on 22/04/2016.
//  Copyright © 2016 haowu. All rights reserved.
//

import UIKit
import CoreData
class getBillData {
    var bills = [Bill]()
    
    
    
    init(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate

        let context = appDelegate.managedObjectContext
        let request = NSFetchRequest(entityName: "Bill")
        do {
            let billObjects = try context.executeFetchRequest(request) as! [Bill]
            bills = billObjects
        } catch {
            let fetchError = error as NSError
            print("\(fetchError), \(fetchError.userInfo)")
        }

    
    }
    
    

}
