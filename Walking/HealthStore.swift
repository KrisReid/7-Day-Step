//
//  HealthStore.swift
//  Walking
//
//  Created by Kris Reid on 24/11/2020.
//

import Foundation
import HealthKit

class HealthStore {
    var healthStore: HKHealthStore?
    var query: HKStatisticsCollectionQuery?
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
        }
    }
    
    func calculateSteps(completion: @escaping (HKStatisticsCollection?) -> Void) {
        
//        let toothType = HKCategoryTypeIdentifier.toothbrushingEvent
        
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        let startDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())
        
        let anchorDate = Date.mondyAt12AM()
        
        let daily = DateComponents(day: 1)
        
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: Date(), options: .strictStartDate)
        
        query = HKStatisticsCollectionQuery(quantityType: stepType, quantitySamplePredicate: predicate, options: .cumulativeSum, anchorDate: anchorDate, intervalComponents: daily)
        
        query!.initialResultsHandler = { query, statisticsCollection, error in
            completion(statisticsCollection)
        }
        
        if let healthStore = healthStore, let query = self.query {
            healthStore.execute(query)
        }
        
    }
    
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        let stepType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.stepCount)!
        
        guard let healthStore = self.healthStore else { return }
        
        healthStore.requestAuthorization(toShare: [], read: [stepType]) { (success, error) in
            completion(success)
        }
    }
}
