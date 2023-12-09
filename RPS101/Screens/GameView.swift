//
//  GameView.swift
//  RPS101
//
//  Created by Sharan Thakur on 09/12/23.
//

import SwiftUI

enum GameState: String, CaseIterable {
    case userPicking
    case aiPicking
    case finished
}

struct GameView: View {
    @Environment(\.rpsObjects) var rpsObjects
    
    @State var selected = 0
    @State var gameState: GameState = .userPicking
    @State var showingConfirmation = false
    
    var body: some View {
        ZStack(alignment: .center) {
            let object = rpsObjects[selected]
            
            Color(.background).ignoresSafeArea()
            
            VStack(spacing: 30) {
                switch gameState {
                case .userPicking:
                    userPickingStage(object)
                case .aiPicking:
                    aiPickingStage(object)
                case .finished:
                    finishedStage(object)
                }
            }
        }
        .background(Color("Background"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Game View")
        .confirmationDialog("Are you sure?", isPresented: $showingConfirmation) {
            Button("Yes, I am sure!") {
                executeAfter(firstBlock: {
                    withAnimation {
                        self.gameState = .aiPicking
                    }
                }, delay: 1) {
                    withAnimation {
                        self.gameState = .finished
                    }
                }
            }
            Button("No, wait.") {
                self.showingConfirmation = false
            }
        } message: {
            Text("Are you sure you want to choose \"\(rpsObjects[selected].name)\"?")
        }
    }
    
    @ViewBuilder
    func finishedStage(_ object: RPSObject) -> some View {
        let aiChosen = rpsObjects.randomElement()!
        
        VStack {
            HStack {
                Text("Player has chosen:")
                Text(object.name)
                    .fontWeight(.heavy)
            }
            .font(.title2)
            
            Image(object.name)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
        }
        
        let playerWinReason = object.canWinAgainstWithReason(against: aiChosen)
        let aiWinReason = aiChosen.canWinAgainstWithReason(against: object)
        
        VStack {
            if let reason = playerWinReason {
                HStack(spacing: 0) {
                    Text("You win! ")
                    Text(" \(object.name) ")
                        .bold()
                    Text(" \(reason[0]) ")
                        .italic()
                    Text(" \(aiChosen.name)")
                        .bold()
                }
                .font(.headline)
                .foregroundColor(.green)
                .sensoryFeedback(.success, trigger: playerWinReason != nil)
                .overlay(alignment: .center) {
                    ConfettiView()
                }
            } else if let reason = aiWinReason {
                HStack(spacing: 0) {
                    Text("Oops! you lose ☹️ ")
                    Text(" \(aiChosen.name) ")
                        .bold()
                    Text(" \(reason[0]) ")
                        .italic()
                    Text(" \(object.name)")
                        .bold()
                }
                .font(.headline)
                .foregroundColor(.red)
                .sensoryFeedback(.error, trigger: aiWinReason != nil)
            } else {
                Text("It's a draw!")
                    .font(.headline.bold())
                    .foregroundColor(.orange)
                    .sensoryFeedback(.warning, trigger: playerWinReason == aiWinReason)
                    .padding(.bottom, 10)
                
                Button {
                    withAnimation {
                        gameState = .userPicking
                    }
                } label: {
                    Label("Retry", systemImage: "arrow.counterclockwise")
                        .font(.headline.bold())
                }
                .buttonStyle(.bordered)
            }
        }
        
        
        VStack {
            Image(aiChosen.name)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            
            HStack {
                Text("AI has chosen:")
                Text(aiChosen.name)
                    .fontWeight(.heavy)
            }
            .font(.title2)
        }
    }
    
    @ViewBuilder
    func aiPickingStage(_ object: RPSObject) -> some View {
        VStack {
            HStack {
                Text("Player has chosen:")
                Text(object.name)
                    .fontWeight(.heavy)
            }
            .font(.title2)
            
            Image(object.name)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
        }
        
        ProgressView()
        
        VStack {
            HStack {
                Text("AI is choosing:")
                Text("...")
            }
            .font(.title2)
            .padding(.bottom)
            
            Text("🤔")
                .font(.largeTitle)
        }
    }
    
    @ViewBuilder
    func userPickingStage(_ object: RPSObject) -> some View {
        Image(object.name)
            .resizable()
            .scaledToFit()
            .frame(height: 200)
        
        Picker("Choose an object", selection: $selected) {
            ForEach(rpsObjects.indices, id: \.self) { index in
                Text(rpsObjects[index].name)
            }
        }
        .pickerStyle(.navigationLink)
        .padding(.horizontal, 20)
        
        ObjectView(rpsObject: object)
            .toolbar {
                Button("Choose") {
                    self.showingConfirmation = true
                }
            }
    }
    
    func executeAfter(firstBlock: () -> Void, delay time: TimeInterval, block: @escaping () -> Void) {
        firstBlock()
        DispatchQueue.main.asyncAfter(deadline: .now() + time, execute: DispatchWorkItem(block: block))
    }
}

#Preview {
    NavigationStack {
        GameView()
            .preferredColorScheme(.dark)
    }
}
