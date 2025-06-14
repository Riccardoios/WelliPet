//
//  ContentView.swift
//  Tamagoci wellness Watch App
//
//  Created by Riccardo Carlotto on 14/06/25.
//

import SwiftUI

struct TamagociView: View {
    @State  private var viewModel = TamagociViewModel()
    
    var body: some View {
        VStack(spacing: 8) {
            AnimatedImages(images: viewModel.status.images)
            HStack {
                ProgressView("Life", value: viewModel.status.life)
                    .progressViewStyle(LinearProgressViewStyle())
                    .padding([.leading, .trailing])
                VStack {
                    Text(" BPM")
                    Text(viewModel.currentHeartRate, format: .number.precision(.fractionLength(0)))
                }
            }
        }
    }
}

#Preview {
    TamagociView()
}
