//
//  CuteMapView.swift
//  RPS101
//
//  Created by Sharan Thakur on 09/12/23.
//

import MapKit
import SwiftUI

struct CuteMapView: View {
    var body: some View {
        mapView()
        .background {
            Color.purple
                .ignoresSafeArea()
        }
    }
    
    @ViewBuilder
    func mapView(_ size: CGFloat = 200.0) -> some View {
        HStack(spacing: 0) {
            Map {
                Marker("Esha", monogram: Text("🐈"), coordinate: .esha)
            }
            
            Color.black
                .frame(width: 10, height: .infinity)
            
            Map {
                Marker("Sharan", monogram: Text("🍪"), coordinate: .sharanJK)
            }
        }
        .mapStyle(.hybrid(elevation: .realistic))
        .mapControls {
            MapScaleView()
            MapCompass()
            MapPitchToggle()
            MapUserLocationButton()
        }
        .mask {
            ZStack{
                Rectangle()
                    .frame(width: size, height: size, alignment: .center)
                    .foregroundColor(.red)
                    .cornerRadius(5)
                
                Circle()
                    .frame(width: size, height: size, alignment: .center)
                    .foregroundColor(.red)
                    .padding(.top, -size)
                
                Circle()
                    .frame(width: size, height: size, alignment: .center)
                    .foregroundColor(.red)
                    .padding(.trailing, -size)
            }
            .rotationEffect(Angle(degrees: -45))
        }
    }
}

extension CLLocationCoordinate2D {
    static let sharan = CLLocationCoordinate2D(latitude: -6.1371244, longitude: 106.8530793)
    static let sharanJK = CLLocationCoordinate2D(latitude: -6.2297401, longitude: 106.7471169)
    static let esha = CLLocationCoordinate2D(latitude: 18.565541, longitude: 73.8347714)
}

#Preview {
    NavigationStack {
        CuteMapView()
    }
}
