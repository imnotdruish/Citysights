//
//  ContentView.swift
//  Citysights
//
//  Created by Dan June on 6/15/25.
//

import SwiftUI

struct ContentView: View {
    @State var query: String = ""
    var service = DataService()
    
    var body: some View {
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
        .padding()
        .task {
            await service.businessSearch()
        }
    }
}

#Preview {
    ContentView()
}
