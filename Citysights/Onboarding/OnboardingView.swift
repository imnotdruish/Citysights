//
//  OnboardingView.swift
//  Citysights
//
//  Created by Dan June on 6/20/25.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedViewIndex = 0

    var body: some View {
                
        ZStack {
            if selectedViewIndex == 0 {
                Color(.onboardingBlue)
            } else {
                Color(.onboardingGreen)
            }
            
            TabView(selection: $selectedViewIndex) {
                OnboardingViewDetails(bgColor: .onboardingBlue, headline: "Welcome to City Sights", subHeadline: "City Sights helps you find the best of the city!", buttonAction: {
                    withAnimation {
                        selectedViewIndex = 1
                    }
                })
                .tag(0)
                .ignoresSafeArea()
                
                OnboardingViewDetails(bgColor: .onboardingGreen, headline: "Discover your city", subHeadline: "We'll show you the best restaurants, venues, and more, based on your location.", buttonAction: {
                    withAnimation {
                        dismiss()
                    }
                })
                .tag(1)
                .ignoresSafeArea()

            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack {
                Spacer()
                HStack(spacing: 16) {
                    Spacer()
                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 0 ? .white : .gray)

                    Circle()
                        .frame(width: 10)
                        .foregroundStyle(selectedViewIndex == 1 ? .white : .gray)

                    Spacer()
                }
                .padding(.bottom, 190)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    OnboardingView()
}
