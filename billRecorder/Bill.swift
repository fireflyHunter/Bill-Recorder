//
//  Bill+CoreDataProperties.swift
//  billRecorder
//
//  Created by 吴昊 on 19/04/2016.
//  Copyright © 2016 haowu. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

class Bill: NSManagedObject {

    @NSManaged var amount: NSNumber?
    @NSManaged var category: String?
    @NSManaged var type: NSNumber?
    @NSManaged var date: NSDate?

}
