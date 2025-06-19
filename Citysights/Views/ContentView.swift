//
//  ContentView.swift
//  Citysights
//
//  Created by Dan June on 6/15/25.
//

import SwiftUI

struct ContentView: View {

    @Environment(BusinessModel.self) var model
        
    var body: some View {
        
        @Bindable var model = model

        VStack {
            HStack {
                TextField("What are you looking for?", text: $model.query)
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
            
            List {
                ForEach(model.businesses) { b in
                    VStack(spacing: 20) {
                        HStack(spacing: 0) {
                            Image("list-placeholder-image")
                                .padding(.trailing, 16)
                            VStack(alignment: .leading) {
                                Text(b.name ?? "Name")
                                    .font(Font.system(size: 15))
                                    .fontWeight(.semibold)
                                Text(TextHelper.distanceAwayText(meters: b.distance ?? 0))
                                    .font(Font.system(size: 16))
                                    .foregroundStyle(Color(red: 67/255, green: 71/255, blue: 76/255))
                            }
                            Spacer()
                            if b.rating != nil {
                                let result = roundedNum(num: b.rating ?? 0)
                                HStack {
                                    Image("regular_\(result)")
                                }
                            }
                        }
                        Divider()
                    }
                    .onTapGesture {
                        model.selectedBusiness = b
                    }
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .onAppear {
            model.getBusinesses()
        }
        .sheet(item: $model.selectedBusiness) { item in
            BusinessDetailView()
        }
    }
}

#Preview {
    ContentView()
}
