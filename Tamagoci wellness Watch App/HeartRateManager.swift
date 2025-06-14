//
//  TamagociViewModel 2.swift
//  Tamagoci wellness
//
//  Created by Riccardo Carlotto on 14/06/25.
//

import SwiftUI
import HealthKit
import Combine


@Observable
class HeartRateManager {
    private let healthStore = HKHealthStore()
    private var heartRateQuery: HKAnchoredObjectQuery?
    
    var currentHeartRate: Double = 0
    
    init() {
        requestAuthorization()
    }
    
    // Requests permission to read heart‑rate data.
    private func requestAuthorization() {
        guard HKHealthStore.isHealthDataAvailable() else { return }
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }
        
        healthStore.requestAuthorization(toShare: [], read: [heartRateType]) { [weak self] success, _ in
            if success {
                self?.startQuery()
            }
        }
    }
    
    // Starts an anchored query that delivers live heart‑rate updates.
    func startQuery() {
        guard let heartRateType = HKQuantityType.quantityType(forIdentifier: .heartRate) else { return }
        
        let predicate = HKQuery.predicateForSamples(withStart: Date.distantPast,
                                                    end: nil,
                                                    options: .strictStartDate)
        
        let query = HKAnchoredObjectQuery(type: heartRateType,
                                          predicate: predicate,
                                          anchor: nil,
                                          limit: HKObjectQueryNoLimit) { [weak self] _, samples, _, _, _ in
            self?.process(samples)
        }
        
        query.updateHandler = { [weak self] _, samples, _, _, _ in
            self?.process(samples)
        }
        
        healthStore.execute(query)
        heartRateQuery = query
    }
    
    // Converts HealthKit samples into a BPM value and publishes it on the main thread.
    private func process(_ samples: [HKSample]?) {
        guard let quantitySamples = samples as? [HKQuantitySample],
              let lastSample = quantitySamples.last else { return }
        
        let bpmUnit = HKUnit(from: "count/min")
        let bpm = lastSample.quantity.doubleValue(for: bpmUnit)
        
        DispatchQueue.main.async {
            self.currentHeartRate = bpm
        }
    }
    
    deinit {
        if let query = heartRateQuery {
            healthStore.stop(query)
        }
    }
}
