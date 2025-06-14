//
//  AnimatedImages.swift
//  Tamagoci wellness
//
//  Created by Riccardo Carlotto on 14/06/25.
//

import SwiftUI
import Combine

// MARK: - AnimatedImages View
struct AnimatedImages: View {
    let images: [Image]
    let interval: TimeInterval

    @State private var currentIndex: Int = 0
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>

    init(images: [Image], interval: TimeInterval = 1.0) {
        self.images = images
        self.interval = interval
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
    }

    var body: some View {
        images[currentIndex]
            .resizable()
            .scaledToFit()
            .onReceive(timer) { _ in
                currentIndex = (currentIndex + 1) % images.count
            }
    }
}

struct AnimatedImages_Previews: PreviewProvider {
    static var previews: some View {
        AnimatedImages(
            images: [
                Image("Layer 1"),
                Image("Layer 2"),
                Image("Layer 3"),
                Image("Layer 4")
            ],
            interval: 1.0
        )
    }
}
