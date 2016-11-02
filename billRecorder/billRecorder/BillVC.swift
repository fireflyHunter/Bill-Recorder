//
//  BillVC.swift
//  billRecorder
//
//  Created by 吴昊 on 16/04/2016.
//  Copyright © 2016 haowu. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class BillVC: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate,UITextViewDelegate {
    @IBOutlet var quitButton: UIButton!
    @IBOutlet var BillType: UISegmentedControl!
    @IBOutlet var BillAmount: UITextField!
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var BillCategory: UIPickerView!
    private struct Constant{
        
        static let cornerRadius = 0.5
        static let pickerViewData = ["Salary","Debt","Cash","Other"]
        static let pickerViewHeight = CGFloat(22.0)
    }
    var Category: String = "Salary"
    
    
    
    
    var Type: Bool{
        get{
            return Bool(BillType.selectedSegmentIndex)
        }
        
        set{
            BillType.selectedSegmentIndex = Int(newValue)
        }
    }
    
    var Amount: Float{
        get{
            if (BillAmount.text != nil){
                return Float(BillAmount.text!)!}
            else{
            return -1}
        }
    
        set{
        BillAmount.text = "\(newValue)"
        }
    }

   
    @IBAction func quitCurrentView(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {
            }
        )
        
    }
    @IBAction func AmountRecord(sender: UITextField) {
        Amount = Float(sender.text!)!
        sender.resignFirstResponder()
        
    }

    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    //pickerview set row number
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return Constant.pickerViewData.count
        
        
    }
    //pickerview set data
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        return Constant.pickerViewData[row]
    }
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return Constant.pickerViewHeight
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Category = Constant.pickerViewData[row]
    }
    
    @IBAction func SaveData(sender: UIButton) {
        let Date = NSDate()

        print(self.Category)
        print(self.Type)
        print(self.Amount)
        print(Date)
        if(self.Amount <= 0){
            
        let alert = UIAlertView()
        alert.title = "warning"
        alert.message = "Input a correct amount"
        alert.addButtonWithTitle("OK")
        alert.show()
        return
        }

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Bill",
                inManagedObjectContext:managedContext)
        let bill = NSManagedObject(entity: entity!,
                    insertIntoManagedObjectContext: managedContext)
        
        bill.setValue(self.Category, forKey: "category")
        bill.setValue(self.Type, forKey: "type")
        bill.setValue(self.Amount, forKey: "amount")
        bill.setValue(Date, forKey: "date")
        appDelegate.saveContext()

        print("Category is: " + self.Category)
        print("Type is: " + "\(self.Type)")
        print("Amount is: " + "\(self.Amount)")
        print("Date is: " + "\(Date)")
        
        
        self.dismissViewControllerAnimated(true, completion: {
            }
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BillCategory.delegate = self
        BillCategory.dataSource = self
        setupButton(saveButton)
        // Do any additional setup after loading the view.
    }
    func setupButton(button:UIButton){
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0.8
    }

}
