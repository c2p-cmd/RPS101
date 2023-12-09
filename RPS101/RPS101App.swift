//
//  RPS101App.swift
//  RPS101
//
//  Created by Sharan Thakur on 06/12/23.
//

import SwiftUI

@main
struct RPS101App: App {
    let fileService: FileService = .shared
    let rpsObjects: [RPSObject]
    
    init() {
        do {
            self.rpsObjects = try fileService.loadData()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.dark)
                .environment(\.rpsObjects, self.rpsObjects)
        }
    }
}
