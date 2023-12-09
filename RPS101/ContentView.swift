//
//  ContentView.swift
//  RPS101
//
//  Created by Sharan Thakur on 06/12/23.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.rpsObjects) var rpsObjects
    
    @State var rpsObjectName = "Air"
    
    let timer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .bottom) {
                    Image(rpsObjectName)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                    
                    Spacer()
                    
                    LinearGradient(
                        colors: [
                            .orange,
                            .orange.opacity(0.8),
                            .pink.opacity(0.5),
                            .pink,
                            .pink
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .frame(height: 50)
                    .mask {
                        Text(rpsObjectName)
                            .font(.title)
                            .fontWeight(.semibold)
                            .fontWidth(.expanded)
                    }
                    
                    
                    Spacer()
                }
                .transition(.opacity)
                .id(rpsObjectName)
                
                Text("Welcome to RPS 101!")
                    .font(.title)
                    .fontDesign(.monospaced)
                    .fontWeight(.black)
                
                Spacer()
                
                VStack(alignment: .center, spacing: 50) {
                    HStack(spacing: 0) {
                        Color.pink
                        Color.purple
                        Color.blue
                        Color.cyan
                        Color.green
                        Color.green
                        Color.yellow
                        Color.orange
                        Color.orange
                    }
                    .rotationEffect(.degrees(15))
                    .mask {
                        Text("Ever wondered what Rock, Paper, Scissors would be like if it had 101 objects instead of 3?")
                            .multilineTextAlignment(.center)
                            .font(.title2.italic())
                            .fontDesign(.monospaced)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                    }
                    .background {
                        Color.gray.opacity(0.25)
                    }
                    .frame(height: 200)
                    .clipShape(.rect(cornerRadius: 30))
                    
                    VStack {
                        NavigationLink {
                            AllObjectsView()
                        } label: {
                            Label("View All Hand Signs", systemImage: "hand.point.right.fill")
                        }
                        .buttonStyle(CustomButton())
                        
                        NavigationLink {
                            GameView()
                        } label: {
                            Label("Play vs AI", systemImage: "desktopcomputer")
                        }
                        .buttonStyle(CustomButton())
                    }
                }
                
                Spacer()
            }
            .padding()
            .navigationTitle("RPS 101")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color("Background"))
            .toolbar {
                NavigationLink("📍") {
                    CuteMapView()
                        .navigationBarBackButtonHidden()
                }
            }
        }
        .onReceive(timer) { _ in
            withAnimation(.bouncy) {
                self.rpsObjectName = rpsObjects.randomElement()!.name
            }
        }
        .onAppear {
            self.rpsObjectName = rpsObjects.randomElement()!.name
        }
    }
}

#Preview {
    ContentView()
        .preferredColorScheme(.dark)
}
