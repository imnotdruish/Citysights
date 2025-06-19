//
//  MapView.swift
//  Citysights
//
//  Created by Dan June on 6/19/25.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Environment(BusinessModel.self) var model
    @State var selectedBusinessId: String?
    
    var body: some View {
        Map(selection: $selectedBusinessId) {
            ForEach(model.businesses, id: \.id) { b in
                Marker(b.name ?? "Restaurant", coordinate: CLLocationCoordinate2D(
                    latitude: b.coordinates?.latitude ?? 0,
                    longitude: b.coordinates?.longitude ?? 0)
                )
                .tag(b.id ?? "None")
            }
        }
        .onChange(of: selectedBusinessId) { oldValue, newValue in
            // Find the business which matches this id
            let business = model.businesses.first { $0.id == newValue }
            
            // if the business is found, set it as the selected one
            if let business = business {
                model.selectedBusiness = business
            }
        }
    }
}

#Preview {
    MapView()
}
