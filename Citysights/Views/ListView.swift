//
//  ListView.swift
//  Citysights
//
//  Created by Dan June on 6/19/25.
//

import SwiftUI

struct ListView: View {
    
    @Environment(BusinessModel.self) var model
    
    var body: some View {
        List {
            ForEach(model.businesses) { b in
                VStack(spacing: 20) {
                    HStack(spacing: 0) {
                        
                        if let imageURL = b.imageURL {
                            AsyncImage(url: URL(string: imageURL)!) { image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 50, height: 50)
                                    .clipShape(RoundedRectangle(cornerRadius: 6))
                                    .padding(.trailing, 16)
                                
                            } placeholder: {
                                ProgressView()
                            }
                        } else {
                            Image("list-placeholder-image")
                                .padding(.trailing, 16)
                        }
                        
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
}

#Preview {
    ListView()
        .environment(BusinessModel())
}
