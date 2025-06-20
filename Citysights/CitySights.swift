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
    @AppStorage("onboarding") var needsOnboarding = true
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(model)
                .fullScreenCover(isPresented: $needsOnboarding) {
                    needsOnboarding = false
                } content: {
                    OnboardingView()
                        .environment(model)
                }
                .onAppear {
                    // if no onboarding is needed, still get location
                    if needsOnboarding == false {
                        model.getUserLocation()
                    }
                }
        }
    }
}
