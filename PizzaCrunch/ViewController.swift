//
//  ViewController.swift
//  PizzaCrunch
//
//  Created by Ahad Sheriff on 1/29/16.
//  Copyright © 2016 Ahad Sheriff. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    @IBOutlet weak var displayData: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Asks the user to allow access to HealthKit data
        
        let healthStore = HKHealthStore()
        
        
        // Start and end date are the same because we want to collect data within the same day
        let startDate = NSDate()
        let endDate = NSDate()
        
        if let energyType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned) {
            
            let setType = Set<HKSampleType>(arrayLiteral: energyType)
            healthStore.requestAuthorizationToShareTypes(setType, readTypes: setType, completion: { (success, error) -> Void in
            })
        }
        
        if let energyType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned) {
            
            // Predicate so that we collect data from within the same day
            
            let timeFrame = HKQuery.predicateForSamplesWithStartDate(startDate, endDate: endDate, options: .None)
            
            // Sort descriptor to get most recent data first
            
            let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
            
            // Execute query and gather Health data
            
            healthStore.executeQuery(HKSampleQuery(sampleType: energyType, predicate: timeFrame, limit: 1, sortDescriptors: [sortDescriptor], resultsHandler: { (query: HKSampleQuery?, results: [HKSample]?, err: NSError?) -> Void in
                if err != nil {
                    // ERROR Occurred, handled it
                    print(err)
                    return
                }
                var labelText = ""
                for result in results as! [HKQuantitySample]! {
                    // SUCCESS, use results here
                    labelText += "\(result)"
                }
                self.displayData.text = labelText
            }))
            
        }
        
        
        
        
        
        //
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

