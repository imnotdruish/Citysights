//
//  CitysightsApp.swift
//  Citysights
//
//  Created by Dan June on 6/15/25.
//

import SwiftUI

@main
struct CitysightsApp: App {
    
    @State var model = BusinessModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model)
        }
    }
}
