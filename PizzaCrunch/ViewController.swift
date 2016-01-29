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
        
        let healthStore = HKHealthStore()
        
        if let energyType = HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierActiveEnergyBurned) {
            
            let setType = Set<HKSampleType>(arrayLiteral: energyType)
            healthStore.requestAuthorizationToShareTypes(setType, readTypes: setType, completion: { (success, error) -> Void in
            })
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

