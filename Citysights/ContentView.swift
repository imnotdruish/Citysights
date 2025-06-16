//
//  ContentView.swift
//  Citysights
//
//  Created by Dan June on 6/15/25.
//

import SwiftUI

struct ContentView: View {
    @State var query: String = ""
    
    var body: some View {
        HStack {
            TextField("What're you looking for?", text: $query)
                .textFieldStyle(.roundedBorder)

            Button {
                search()
            } label: {
                Text("Go")
            }
        }
        .padding()
    }
    
    func search() {
        print(query)
    }
}

#Preview {
    ContentView()
}
