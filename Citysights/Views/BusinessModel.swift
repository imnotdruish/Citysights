//
//  BusinessModel.swift
//  Citysights
//
//  Created by Dan June on 6/19/25.
//

import Foundation
import SwiftUI

@Observable
class BusinessModel {
    
    var businesses = [Business]()
    var query: String = ""
    var selectedBusiness: Business?
    
    var service = DataService()
    
    func getBusinesses() {
        
        Task {
            businesses = await service.businessSearch()
        }
    }
}
