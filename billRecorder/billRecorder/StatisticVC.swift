//
//  StatisticVC.swift
//  billRecorder
//
//  Created by 吴昊 on 21/04/2016.
//  Copyright © 2016 haowu. All rights reserved.
//

import UIKit

class StatisticVC: UIViewController,PiechartDelegate {
    @IBOutlet var typeSeg: UISegmentedControl!
    var bills = [Bill]()
    var piechart = Piechart()
    var InShares = [0.0,0.0,0.0,0.0]
    var OutShares = [0.0,0.0,0.0,0.0]

    @IBOutlet var refreshButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("enter statistic")
        getData()
        calculateShare()
        if(!IsEmpty(InShares)){
        showPiechart(InShares, title: "Income")
        }
        print(InShares)
        print(OutShares)
        setupButton(refreshButton)
        
        // Do any additional setup after loading the view.
    }
    func refresh(){
    getData()
    calculateShare()
    }
    func setupButton(button:UIButton){
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.layer.borderWidth = 0.8
    }
    @IBAction func refreshButtonClick(sender: UIButton) {
        piechart.removeFromSuperview()
        refresh()
        if (typeSeg.selectedSegmentIndex == 0){
            if(!IsEmpty(InShares)){
                showPiechart(InShares, title: "Income")
            }
            
        }
        else if(!IsEmpty(OutShares)){
            showPiechart(OutShares, title: "Expenses")
        }
    }
    func showPiechart(data:[Double], title:String){
        piechart.removeFromSuperview()
        var views: [String: UIView] = [:]
        
        var Salary = Piechart.Slice()
        Salary.value = CGFloat(data[0])
        Salary.color = UIColor.magentaColor()
        Salary.text = "Salary"
        
        var Debt = Piechart.Slice()
        Debt.value = CGFloat(data[1])
        Debt.color = UIColor.blueColor()
        Debt.text = "Debt"
        
        var Cash = Piechart.Slice()
        Cash.value = CGFloat(data[2])
        Cash.color = UIColor.redColor()
        Cash.text = "Cash"
        
        var Other = Piechart.Slice()
        Other.value = CGFloat(data[3])
        Other.color = UIColor.yellowColor()
        Other.text = "Other"
        
        
        piechart.delegate = self
        piechart.title = title
        piechart.activeSlice = 2
        piechart.layer.borderWidth = 1
        piechart.slices = [Salary, Debt, Cash, Other]
        
        piechart.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(piechart)
        views["piechart"] = piechart
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[piechart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-200-[piechart(==200)]", options: [], metrics: nil, views: views))
    
    }
    func calculateShare(){
         InShares = [0.0,0.0,0.0,0.0]
         OutShares = [0.0,0.0,0.0,0.0]
        for bill in bills{
            let category = bill.valueForKey("category") as! String
            let amount = bill.valueForKey("amount") as! Double
            if (bill.valueForKey("type") as! Int == 0){
                switch category{
                case "Salary":
                    InShares[0] += amount
                case "Debt":
                    InShares[1] += amount
                case "Cash":
                    InShares[2] += amount
                case "Other":
                    InShares[3] += amount
                default:
                    break
                }
            }
            else{
                switch category{
                case "Salary":
                    OutShares[0] += amount
                case "Debt":
                    OutShares[1] += amount
                case "Cash":
                    OutShares[2] += amount
                case "Other":
                    OutShares[3] += amount
                default:
                    break
                }
            }
        }
    }

  
    @IBAction func clickToShift(sender: UISegmentedControl) {
        
        if (sender.selectedSegmentIndex == 0){
            if(!IsEmpty(InShares)){
            showPiechart(InShares, title: "Income")
            }
        
        }
        else if(!IsEmpty(OutShares)){
        showPiechart(OutShares, title: "Expenses")
        }
        
    }
    func getData() {
        bills = getBillData().bills
    }
    func normaliseArray(var array: [Double]){
        let sum = array.reduce(0,combine: +)
        
        for index in 1...array.count{
        array[index-1]=array[index-1]/sum
        }
    }
    func IsEmpty( array: [Double])->Bool{
        let sum = array.reduce(0,combine: +)
        return (sum == 0)
    }
    func setSubtitle(total: CGFloat, slice: Piechart.Slice) -> String {
        
        return "\(Int(slice.value / total * 100))% \(slice.text)"
    }
    
    func setInfo(total: CGFloat, slice: Piechart.Slice) -> String {
        return "\(Int(slice.value))/\(Int(total))"
    }
}