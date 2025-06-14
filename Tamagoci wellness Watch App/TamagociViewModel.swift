//
//  TamagociViewModel.swift
//  Tamagoci wellness
//
//  Created by Riccardo Carlotto on 14/06/25.
//

import SwiftUI

@Observable
class TamagociViewModel {
    var life: Double = 1.0

    init() {}
    
    private func getHealthStatus() -> TamagociStatus {
        return .dead
    }

    deinit {}
}

enum TamagociStatus {
    case happy
    case dead
    
    var images: [Image] {
        switch self {
        case .happy:
            return [
                Image("happy-1"),
                Image("happy-2"),
                Image("happy-3"),
                Image("happy-4"),
            ]
        case .dead:
            return [
                Image("dead-1"),
                Image("dead-2"),
                Image("dead-3"),
                Image("dead-4"),
            ]
        }
    }
}
