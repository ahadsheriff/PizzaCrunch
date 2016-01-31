//
//  InterfaceController.swift
//  PizzaCrunchWatch Extension
//
//  Created by Ahad Sheriff on 1/31/16.
//  Copyright © 2016 Ahad Sheriff. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var pizzaLabel: WKInterfaceLabel!

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        // Configure interface objects here.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "displayData:", name: "pizzaSlices", object: nil)
        
    }
    
    func displayData(notification: NSNotification) {
        let data = notification.userInfo!["data"] as! String
        self.pizzaLabel.setText(data)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
