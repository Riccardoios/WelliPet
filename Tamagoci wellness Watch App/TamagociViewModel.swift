//
//  TamagociViewModel.swift
//  Tamagoci wellness
//
//  Created by Riccardo Carlotto on 14/06/25.
//

import SwiftUI

@Observable
class TamagociViewModel {
    private var heartRateManager = HeartRateManager()
    
    var currentHeartRate: Double {
        heartRateManager.currentHeartRate
    }
    
    var status: TamagociStatus {
        if currentHeartRate < 80 {
            return .verySad
        } else {
            return .happy
        }
    }

    init() {}
}

enum TamagociStatus {
    case happy
    case verySad
    
    var images: [Image] {
        switch self {
        case .happy:
            return [
                Image("happy-1"),
                Image("happy-2"),
                Image("happy-3"),
                Image("happy-4"),
            ]
        case .verySad:
            return [
                Image("dead-1"),
                Image("dead-2"),
                Image("dead-3"),
                Image("dead-4"),
            ]
        }
    }
    
    var life: Double {
        switch self {
        case .happy:
            return 0.8
        case .verySad:
            return 0.2
        }
    }
}
