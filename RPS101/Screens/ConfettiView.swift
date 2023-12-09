//
//  ConfettiView.swift
//  RPS101
//
//  Created by Sharan Thakur on 09/12/23.
//

import SwiftUI
import UIKit

struct ConfettiView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        let emitter = CAEmitterLayer()

        // Configure the emitter
        emitter.emitterShape = .line
        emitter.emitterPosition = view.center
        emitter.emitterSize = view.sizeThatFits(view.frame.size)
        emitter.emitterCells = generateEmitterCells()

        view.layer.addSublayer(emitter)

        // Start with a high birth rate
        emitter.birthRate = 2.5

        // Stop the emitter after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            emitter.birthRate = 0
        }

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    private func generateEmitterCells() -> [CAEmitterCell] {
        var cells: [CAEmitterCell] = []
        
        // Create confetti pieces with different colors
        let colors: [UIColor] = [.red, .green, .blue, .yellow, .purple, .orange]
        
        for color in colors {
            let cell = CAEmitterCell()
            cell.birthRate = 10
            cell.lifetime = 5.0
            cell.velocity = CGFloat(180)
            cell.velocityRange = CGFloat(200)
            cell.emissionLongitude = CGFloat.pi
            cell.emissionRange = CGFloat.pi
            cell.spin = 3.5
            cell.spinRange = 4.0
            cell.color = color.cgColor
            
            if let image = UIImage(systemName: "heart")?.tinted(with: .green) {
                cell.contents = image.cgImage
            }
            cell.scaleRange = 0.25
            cell.scale = 0.1
            
            cells.append(cell)
        }
        
        return cells
    }
}


#Preview {
    VStack {
        Text("Hi")
    }
    .overlay(alignment: .bottom) {
        ConfettiView()
    }
}
