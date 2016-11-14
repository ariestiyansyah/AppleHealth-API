//
//  ViewController.swift
//  tracked
//
//  Created by Aji Achmad Mustofa on 11/7/16.
//  Copyright © 2016 Aji Achmad Mustofa. All rights reserved.
//

import UIKit
import HealthKit
import CoreMotion

class ViewController: UIViewController {
   
    let healthManager:HealthKitManager  = HealthKitManager()
    var stepMotion                      = CMPedometer()
    var isStart:Bool                    = false
    var stepNumber:NSNumber             = 0
    var stepPoint:Int                   = 0
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stepNumberLabel: UILabel!
    @IBOutlet weak var stepPointLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func startTracking(_ sender: UIButton) {
        let date = Date()
        if !self.isStart {
            self.startButton.setTitle("Stop", for: UIControlState.normal)
            self.stepMotion.startUpdates(from: date, withHandler: { (data:CMPedometerData?, error) in
                DispatchQueue.main.async(execute: { () -> Void in
                    if(error == nil){
                        self.updateLabel(data: data!)
                    }
                })
            })
        }else{
            self.stepMotion.stopUpdates()
            self.stepPointLabel.text    = "0 Poin"
            self.stepNumberLabel.text   = "0 Langkah"
            self.stepNumber             = 0
            self.stepPoint              = 0
            self.startButton.setTitle("Start", for: UIControlState.normal)
        }
        isStart = !isStart
    }
    
    func updateLabel(data:CMPedometerData) {
            self.stepNumber             = data.numberOfSteps
            self.stepPoint              = Int(self.stepNumber) / 10
            self.stepPointLabel.text    = "\(String(self.stepPoint)) Poin"
            self.stepNumberLabel.text   = "\(self.stepNumber.stringValue) Langkah"
    }
    
    
    func getHealthKitPermission() {
        // Seek authorization in HealthKitManager.swift.
//        healthManager.authorizeHealthKit { (authorized,  error) -> Void in
//            if authorized {
//                
//                // Get and set the user's height.
//                self.setHeight()
//            } else {
//                if error != nil {
//                    print(error)
//                }
//                print("Permission denied.")
//            }
//        }
    }


}

