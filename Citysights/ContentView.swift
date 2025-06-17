//
//  ContentView.swift
//  Citysights
//
//  Created by Dan June on 6/15/25.
//

import SwiftUI

struct ContentView: View {
    @State var query: String = ""
    @State var businesses = [Business]()
    var service = DataService()
    
    var body: some View {
        VStack {
            HStack {
                TextField("What are you looking for?", text: $query)
                    .textFieldStyle(.roundedBorder)
                
                Button {

                } label: {
                    Text("Go")
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
            }
            
            List (businesses) { b in
                Text(b.name ?? "Nil")
            }
        }
        .padding()
        .task {
            businesses = await service.businessSearch()
        }
    }
}

#Preview {
    ContentView()
}
