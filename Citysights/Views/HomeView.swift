//
//  HomeView.swift
//  Citysights
//
//  Created by Dan June on 6/15/25.
//

import SwiftUI
import CoreLocation

struct HomeView: View {

    @Environment(BusinessModel.self) var model
    @State var selectedTab = 0

    @State var query = ""
    @FocusState var queryBoxFocused: Bool
    
    @State var popularOn = false
    @State var dealsOn = false
    @State var categorySelection = "restaurants"

    var body: some View {
        
        @Bindable var model = model
        
        VStack {
            HStack {
                TextField("What are you looking for?", text: $query)
                    .textFieldStyle(.roundedBorder)
                    .focused($queryBoxFocused)

                Button {
                    withAnimation {
                        queryBoxFocused = false
                    }

                    // Perform a search
                    model.getBusinesses(query: query,
                                        options: getOptionsString(),
                                        category: categorySelection)
                } label: {
                    Text("Go")
                        .padding(.horizontal)
                        .frame(height: 32)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)

                if queryBoxFocused {
                    VStack {
                        HStack {
                            Toggle("Popular", isOn: $popularOn)
                                .padding(.trailing, 20)
                            Toggle("Deals", isOn: $dealsOn)
                                .padding(.leading, 40)
                        }
                        .padding(.horizontal, 30)
                        
                        HStack {
                            Picker("Category", selection: $categorySelection) {
                                Text("Restaurants")
                                    .tag("restaurants")
                                Text("Arts & Entertainment")
                                    .tag("arts")
                            }
                        }
                        .padding(.horizontal, 40)

                    }
                }

            // Show Picker
            Picker("", selection: $selectedTab) {

                Text("List")
                    .tag(0)

                Text("Map")
                    .tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            // Show Map or List
            if model.locationAuthStatus == .denied {
                Spacer()
                
                Text("Please allow locations ervice for this app to see sights near you.")
                    .padding(.horizontal)
                
                Button {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                    
                } label: {
                    Text("Open App Privacy Settings")
                }
                .buttonStyle(.bordered)
                
                Spacer()
                
            } else if selectedTab == 1 {
                MapView()
                    .onTapGesture {
                        withAnimation {
                            queryBoxFocused = false
                        }
                    }

            } else {
                ListView()
                    .onTapGesture {
                        withAnimation {
                            queryBoxFocused = false
                        }
                    }
            }
        }
        .sheet(item: $model.selectedBusiness) { item in
            BusinessDetailView()
        }
    }
    
    func getOptionsString() -> String {
        
        var optionsArray = [String]()
        if popularOn {
            optionsArray.append("hot_and_new")
        }
        if dealsOn {
            optionsArray.append("deals")
        }
        return optionsArray.joined(separator: ",")
    }
}

#Preview {
    HomeView()
        .environment(BusinessModel())
}
