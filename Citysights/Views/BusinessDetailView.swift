//
//  BusinessDetailView.swift
//  Citysights
//
//  Created by Dan June on 6/18/25.
//

import SwiftUI

struct BusinessDetailView: View {
    
    var business: Business?
    
    var body: some View {
        Text(business?.name ?? "")
    }
}

#Preview {
    BusinessDetailView()
}
