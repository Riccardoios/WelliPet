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
            AnimatedImages(images: TamagociStatus.happy.images)
            ProgressView("Life", value: viewModel.life)
                .progressViewStyle(LinearProgressViewStyle())
                .padding([.leading, .trailing])
        }
    }
}

#Preview {
    TamagociView()
}
