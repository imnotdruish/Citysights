//
//  BusinessDetailView.swift
//  Citysights
//
//  Created by Dan June on 6/18/25.
//

import SwiftUI

struct BusinessDetailView: View {
    
    @Environment(BusinessModel.self) var model
    
    var body: some View {
        
        let business = model.selectedBusiness
        
        VStack(spacing: 0) {
            
            ZStack(alignment: .trailing) {
                if let imageURL = business?.imageURL {
                    AsyncImage(url: URL(string: imageURL)!) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 164)
                            .clipped()
                        
                    } placeholder: {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    }
                } else {
                    Image("detail-placeholder-image")
                        .padding(.trailing, 16)
                }
                
                VStack {
                    Spacer()
                    Image("yelp-attribution-image")
                        .frame(width: 72, height: 36)
                }
            }
            .frame(height: 164)
            
            if let isClosed = business?.isClosed {
                ZStack(alignment: .leading) {
                    Rectangle()
                        .foregroundStyle(isClosed ? .red : .green)
                    Text(isClosed ? "Closed" : "Open")
                        .bold()
                        .foregroundStyle(.white)
                        .padding(.horizontal)
                }
                .frame(height: 36)
            }

            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    Text(business?.name ?? "")
                        .font(Font.system(size: 21))
                        .bold()
                        .padding(.bottom, 10)
                        .padding(.top, 16)
                    
                    Text("\(business?.location?.address1 ?? ""), \(business?.location?.city ?? "")")
                    Text("\(business?.location?.state ?? ""), \(business?.location?.zipCode ?? ""), \(business?.location?.country ?? "")")
                        .padding(.bottom, 10)

                    if business?.rating != nil {
                        let result = roundedNum(num: business?.rating ?? 0)
                        HStack {
                            Image("regular_\(result)")
                        }
                        .padding(.bottom, 16)
                    }
                    
                    Divider()
                    
                    HStack {
                        if let url = URL(string: "tel://\(business?.phone ?? "")") {
                            Image(systemName: "phone")
                            Link(destination: url) {
                                Text(business?.phone ?? "")
                            }
                            Spacer()
                            Image(systemName: "arrow.right")

                        } else {
                            Image(systemName: "phone")
                            Text(business?.phone ?? "")
                        }
                    }
                    .padding(.vertical, 12)

                    Divider()
                    
                    HStack {
                        if let url = URL(string: "\(business?.url ?? "")") {
                            Image(systemName: "globe")
                            Link(destination: url) {
                                Text(business?.url ?? "")
                                    .lineLimit(1)
                            }
                            Spacer()
                            Image(systemName: "arrow.right")

                        } else {
                            Image(systemName: "globe")
                            Text(business?.url ?? "")
                                .lineLimit(1)
                        }
                    }
                    .padding(.vertical, 12)
                    
//                    HStack {
//                        Image(systemName: "globe")
//                        Text(business?.url ?? "")
//                            .lineLimit(1)
//                        Spacer()
//                        Image(systemName: "arrow.right")
//                    }
//                    .padding(.vertical, 12)
                    
                    Divider()
                    
                    HStack {
                        Image(systemName: "bubble.left.and.bubble.right")
                        Text("\(business?.reviewCount ?? 0) reviews")
                    }
                    .padding(.vertical, 12)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    BusinessDetailView()
}
