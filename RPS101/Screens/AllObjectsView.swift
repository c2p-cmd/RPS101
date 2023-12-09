//
//  GameView.swift
//  RPS101
//
//  Created by Sharan Thakur on 09/12/23.
//

import SwiftUI

struct AllObjectsView: View {
    @Environment(\.rpsObjects) var rpsObjects
    
    @State private var searchText = ""
    
    init() {
        UITableView.appearance().backgroundColor = UIColor(named: "Background")
    }
    
    var body: some View {
        ZStack {
            Color("Background").ignoresSafeArea()
            
            List(filteredList()) { object in
                NavigationLink {
                    ObjectView(rpsObject: object)
                } label: {
                    HStack {
                        Image(object.name)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 90)
                        
                        Spacer()
                        
                        Text(object.name)
                            .font(.title3)
                    }
                }
                .buttonStyle(.plain)
                .padding(.vertical)
            }
            .listStyle(.plain)
            .searchable(text: $searchText)
            .navigationTitle("All 101 Objects")
        }
    }
    
    func filteredList() -> [RPSObject] {
        if searchText.isEmpty {
            return rpsObjects
        }
        
        return rpsObjects.filter { object in
            object.name.lowercased().contains(searchText.lowercased())
        }
    }
}

#Preview {
    NavigationStack {
        AllObjectsView()
            .preferredColorScheme(.dark)
    }
}
