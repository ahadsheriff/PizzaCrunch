//
//  ViewController.swift
//  PizzaCrunch
//
//  Created by Ahad Sheriff on 1/29/16.
//  Copyright © 2016 Ahad Sheriff. All rights reserved.
//

import UIKit
import HealthKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet weak var midTopRight: UIImageView!
    @IBOutlet weak var topLeft: UIImageView!
    @IBOutlet weak var topRight: UIImageView!
    @IBOutlet weak var bottomLeft: UIImageView!
    @IBOutlet weak var bottomRight: UIImageView!
    @IBOutlet weak var bottomRight2: UIImageView!
    @IBOutlet weak var midLeft: UIImageView!
    @IBOutlet weak var tinyLeft: UIImageView!
    @IBOutlet weak var tinyRight: UIImageView!
    @IBOutlet weak var mid: UIImageView!
    @IBOutlet weak var bottomLeft2: UIImageView!
    @IBOutlet weak var mid2: UIImageView!
    @IBOutlet weak var midRight: UIImageView!
    @IBOutlet weak var midTopLeft: UIImageView!
    
    @IBOutlet weak var displayData: UILabel!
    @IBOutlet weak var pizzaData: UILabel!
    
    var arrayImage : [UIImageView]?
    var data = HKHealthStore()
    var timer: NSTimer?
    var track: Int = 0
    var caseBool1 : Bool = true
    var caseBool2 : Bool = true
    var caseBool3 : Bool = true
    var caseBool4 : Bool = true
    var caseBool5 : Bool = true
    var caseBool6 : Bool = true
    var caseBool7 : Bool = true
    var caseBool8 : Bool = true
    var caseBool9 : Bool = true
    var caseBool10 : Bool = true
    var caseBool11 : Bool = true
    var caseBool12 : Bool = true
    var caseBool13 : Bool = true
    var caseBool14 : Bool = true
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asks the user to allow access to HealthKit data
        arrayImage = [midTopRight, topLeft, topRight, bottomLeft, bottomRight, bottomRight2, midLeft, tinyLeft, tinyRight, mid, bottomLeft2, mid2, midRight, midTopLeft]
        
        if let energyType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned) {
            
            let setType = Set<HKSampleType>(arrayLiteral: energyType)
            data.requestAuthorizationToShareTypes(setType, readTypes: setType, completion: { (success, error) -> Void in
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.loadData()
                    
                    // Below code attempts to refresh the loadData function periodically
                    
                    self.timer = NSTimer.scheduledTimerWithTimeInterval(15, target: self, selector: Selector("loadData"), userInfo: nil, repeats: true)
                })
                
            })
            
        }
        
        
    }
    
    
    var time: NSDate?
    
    func fetch(completion: () -> Void) {
        time = NSDate()
        completion()
    }
    
    
    
    // Collect and load the data
    
    func loadData() {
        
        let startDate = NSDate.distantPast()
        let endDate = NSDate()
        
        if let energyType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned) {
            
            // Predicate so that we collect data from within the same day
            
            let timeFrame = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .None)
            
            // Sort descriptor to get most recent data first
            
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            // Execute query and gather Health data
            
            
            data.executeQuery(HKSampleQuery(sampleType: energyType, predicate: timeFrame, limit: 0, sortDescriptors: [sortDescriptor], resultsHandler: { (query: HKSampleQuery?, results: [HKSample]?, err: NSError?) -> Void in
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if err != nil {
                        // ERROR Occurred
                        print(err)
                        return
                    }
                    var calories = 0
                    var pizzas = 0
                    let caloriesPerPieces = 500/14
                    var totalPiecesAdded = 0
                    var currentValue = 0
                    
                    for result in results as! [HKQuantitySample]! {
                        // SUCCESS, use results here
                        
                        print("Sample:", result)
                        print("Quantity", Int(result.quantity.doubleValueForUnit(HKUnit.calorieUnit())), "Calories")
                        
                        calories += Int(result.quantity.doubleValueForUnit(HKUnit.calorieUnit()))
                        print("Pizzas", pizzas)
                        print("module", calories % 500)
                            UIView.animateWithDuration(2, animations: {
                                
                                switch calories % 500{
                              
                                case caloriesPerPieces..<caloriesPerPieces*2 where self.caseBool1 == true:
                                    self.arrayImage![0].alpha = 1
                                    totalPiecesAdded+=1
                                    currentValue = totalPiecesAdded
                                    self.caseBool1 = false
                                    
                                case caloriesPerPieces*2..<caloriesPerPieces*3 where self.caseBool2 == true:
                                    for i in 0..<2{
                                        self.arrayImage![i].alpha = 1
                                        self.caseBool2 = false
                                    }
                                    totalPiecesAdded = totalPiecesAdded + 2 - currentValue
                                    currentValue = totalPiecesAdded
                                case caloriesPerPieces*3..<caloriesPerPieces*4 where self.caseBool3 == true:
                                    for i in 0..<3{
                                        self.arrayImage![i].alpha = 1
                                        self.caseBool3 = false
                                    }
                                    totalPiecesAdded = totalPiecesAdded + 3 - currentValue
                                    currentValue = totalPiecesAdded
                                case caloriesPerPieces*4..<caloriesPerPieces*5 where self.caseBool4 == true:
                                    for i in 0..<4{
                                        self.arrayImage![i].alpha = 1
                                        self.caseBool4 = false
                                    }
                                    totalPiecesAdded = totalPiecesAdded + 4 - currentValue
                                    currentValue = totalPiecesAdded
                                case caloriesPerPieces*5..<caloriesPerPieces*6 where self.caseBool5 == true:
                                    for i in 0..<5{
                                        self.arrayImage![i].alpha = 1
                                        self.caseBool5 = false
                                    }
                                    totalPiecesAdded = totalPiecesAdded + 5 - currentValue
                                    currentValue = totalPiecesAdded
                                case caloriesPerPieces*6..<caloriesPerPieces*7 where self.caseBool6 == true:
                                    for i in 0..<6{
                                        self.arrayImage![i].alpha = 1
                                        self.caseBool6 = false
                                    }
                                    totalPiecesAdded = totalPiecesAdded + 6 - currentValue
                                    currentValue = totalPiecesAdded
                                case caloriesPerPieces*7..<caloriesPerPieces*8 where self.caseBool7 == true:
                                    for i in 0..<7{
                                        self.arrayImage![i].alpha = 1
                                        self.caseBool7 = false
                                    }
                                    totalPiecesAdded = totalPiecesAdded + 7 - currentValue
                                    currentValue = totalPiecesAdded
                                case caloriesPerPieces*8..<caloriesPerPieces*9 where self.caseBool8 == true:
                                    for i in 0..<8{
                                        self.arrayImage![i].alpha = 1
                                        self.caseBool8 = false
                                    }
                                    totalPiecesAdded = totalPiecesAdded + 8 - currentValue
                                    currentValue = totalPiecesAdded
                                case caloriesPerPieces*9..<caloriesPerPieces*10 where self.caseBool9 == true:
                                    for i in 0..<9{
                                        self.arrayImage![i].alpha = 1
                                        self.caseBool9 = false

                                    }
                                    totalPiecesAdded = totalPiecesAdded + 9 - currentValue
                                    currentValue = totalPiecesAdded
                                case caloriesPerPieces*10..<caloriesPerPieces*11 where self.caseBool10 == true:
                                    for i in 0..<10{
                                        self.arrayImage![i].alpha = 1
                                        self.caseBool10 = false

                                    }
                                    totalPiecesAdded = totalPiecesAdded + 10 - currentValue
                                    currentValue = totalPiecesAdded
                                case caloriesPerPieces*11..<caloriesPerPieces*12 where self.caseBool11 == true:
                                    for i in 0..<11{
                                        self.arrayImage![i].alpha = 1
                                    }

                                    self.caseBool11 = false
                                    totalPiecesAdded = totalPiecesAdded + 11 - currentValue
                                    currentValue = totalPiecesAdded

                                case caloriesPerPieces*12..<caloriesPerPieces*13 where self.caseBool12 == true:
                                    for i in 0..<12{
                                        self.arrayImage![i].alpha = 1
                                        self.caseBool12 = false
                                    }
                                    totalPiecesAdded = totalPiecesAdded + 12 - currentValue
                                    currentValue = totalPiecesAdded
                                case caloriesPerPieces*13..<caloriesPerPieces*14 where self.caseBool13 == true:
                                    for i in 0..<13{
                                        self.arrayImage![i].alpha = 1
                                        self.caseBool13 = false
                                    }
                                    totalPiecesAdded = totalPiecesAdded + 13 - currentValue
                                    currentValue = totalPiecesAdded

                                default:
                                   print("Nothing")
                                }
                            })
                        }
                    
                        pizzas = Int(calories/500)

                        print(totalPiecesAdded)
                    
                        if calories%500 == 0{
                            print("Wat")
                            UIView.animateWithDuration(2, animations: {
                                for i in 0..<14{
                                    self.arrayImage![i].alpha = 0
                                }
                                
                            })
                            self.caseBool1 = true
                            self.caseBool2  = true
                            self.caseBool3  = true
                            self.caseBool4  = true
                            self.caseBool5  = true
                            self.caseBool6  = true
                            self.caseBool7 = true
                            self.caseBool8  = true
                            self.caseBool9  = true
                            self.caseBool10  = true
                            self.caseBool11  = true
                            self.caseBool12 = true
                            self.caseBool13 = true
                            self.caseBool14 = true
                            totalPiecesAdded = 0
                            print(totalPiecesAdded)
                        }
                    
                    
                    self.displayData.text = "\(String(calories)) Calories"
                    self.pizzaData.text = "\(String(pizzas))x"
                    
                })
                
            }))
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
