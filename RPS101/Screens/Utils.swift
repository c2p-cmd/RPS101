//
//  Utils.swift
//  RPS101
//
//  Created by Sharan Thakur on 09/12/23.
//

import SwiftUI
import UIKit

struct CustomButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 194 / 256, green: 18 / 256, blue: 146 / 256).gradient)
                .frame(width: 200, height: 60)
                .clipShape(.rect(cornerRadius: 10))
            
            configuration.label
                .foregroundStyle(.white)
        }
    }
}

extension UIImage {
    func tinted(with color: UIColor) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(.normal)
        
        let rect = CGRect(origin: .zero, size: size)
        context?.clip(to: rect, mask: cgImage!)
        context?.fill(rect)
        
        let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return tintedImage
    }
}

