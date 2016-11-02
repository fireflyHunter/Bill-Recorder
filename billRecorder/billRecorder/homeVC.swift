//
//  homeVC.swift
//  billRecorder
//
//  Created by 吴昊 on 22/04/2016.
//  Copyright © 2016 haowu. All rights reserved.
//

import UIKit
import CoreData

class homeVC: UIViewController {
    var appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var billData = [Bill]()
    @IBOutlet var expensesLabel: UILabel!
    @IBOutlet var remainLabel: UILabel!
    @IBOutlet var incomeLabel: UILabel!
    var totalIncome:Double = 0
    var totalExpenses:Double = 0
    
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var clickToRecord: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setLabels(IncomeLabel: incomeLabel, ExpensesLabel: expensesLabel, RemainLabel: remainLabel)
        setupButton(clickToRecord)
        setupButton(refreshButton)
        

        // Do any additional setup after loading the view.
    }
    @IBAction func refreshButtonClick(sender: UIButton) {
        getData()
        setLabels(IncomeLabel: incomeLabel, ExpensesLabel: expensesLabel, RemainLabel: remainLabel)

    }
    func getData() {
        billData = getBillData().bills
    }
    
    func setupButton(button:UIButton){
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0.8
    }
    
    func setLabels(IncomeLabel IncomeLabel:UILabel, ExpensesLabel:UILabel, RemainLabel:UILabel){
        totalExpenses = 0
        totalIncome = 0
        for bill in billData{
            if let type = bill.valueForKey("type") {
                if (type as! NSNumber == 0){
                    totalIncome += bill.valueForKey("amount") as! Double}
                else{
                    totalExpenses += bill.valueForKey("amount") as! Double}
            }
        
        
        }
        IncomeLabel.text = "\(totalIncome)"
        ExpensesLabel.text = "\(totalExpenses)"
        RemainLabel.text = "\(totalIncome - totalExpenses)"

    
    
    }



}
