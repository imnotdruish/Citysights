//
//  CitySights.swift
//  Citysights
//
//  Created by Dan June on 6/15/25.
//

import SwiftUI

@main
struct CitySights: App {
    
    @State var model = BusinessModel()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(model)
        }
    }
}
