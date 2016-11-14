//
//  HealthKitManager.swift
//  tracked
//
//  Created by Aji Achmad Mustofa on 11/8/16.
//  Copyright © 2016 Aji Achmad Mustofa. All rights reserved.
//

import Foundation
import HealthKit


class HealthKitManager {
    
    let healthKitStore: HKHealthStore = HKHealthStore()
    
    func authorizeHealthKit(completion: ((_ successa: Bool, _ errora: Error?) -> Void)!) {
        
        // State the health data type(s) we want to read from HealthKit.
        let healthDataToRead = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!)
        
        // State the health data type(s) we want to write from HealthKit.
        let healthDataToWrite = Set(arrayLiteral: HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.distanceWalkingRunning)!)
        
        // Just in case OneHourWalker makes its way to an iPad...
        if !HKHealthStore.isHealthDataAvailable() {
            print("Can't access HealthKit.")
        }
        // Request authorization to read and/or write the specific data.
        healthKitStore.requestAuthorization(
            toShare: healthDataToWrite,
            read: healthDataToRead,
            completion:{ (success, error) -> Void in
                if(completion != nil){
                    completion(success, error)
                }
        })
    }
    
}
