//
//  ObjectView.swift
//  RPS101
//
//  Created by Sharan Thakur on 09/12/23.
//

import SwiftUI

struct ObjectView: View {
    var rpsObject: RPSObject
    
    @State var searchText: String = ""
    
    init(rpsObject: RPSObject) {
        self.rpsObject = rpsObject
        UITableView.appearance().backgroundColor = UIColor(named: "Background")
    }
    
    var body: some View {
        VStack {
            Text("Winning outcomes:")
                .fontWeight(.heavy)
            
            List(filteredList(), id: \.hashValue) { outcome in
                HStack(spacing: 3) {
                    Text(rpsObject.name)
                    ForEach(outcome[0].split(separator: " "), id: \.self) {
                        Text($0)
                            .italic()
                            .bold()
                    }
                    Text(outcome[1])
                        .fontWeight(.black)
                }
            }
            .listStyle(.plain)
            .background(Color("Background"))
            .searchable(text: $searchText)
        }
        .navigationTitle(rpsObject.name)
    }
    
    func filteredList() -> [[String]] {
        if searchText.isEmpty {
            return rpsObject.winningOutcomes
        }
        
        return rpsObject.winningOutcomes.filter { list in
            list[1].lowercased().contains(searchText.lowercased())
        }
    }
}
