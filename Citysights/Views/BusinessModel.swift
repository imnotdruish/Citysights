//
//  BusinessModel.swift
//  Citysights
//
//  Created by Dan June on 6/19/25.
//

import Foundation
import SwiftUI
import CoreLocation

@Observable
class BusinessModel: NSObject, CLLocationManagerDelegate {
    
    var businesses = [Business]()
    var selectedBusiness: Business?
    
    var service = DataService()
    var locationManager = CLLocationManager()
    var currentUserLocation: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.delegate = self
    }
    
    func getBusinesses(query: String?, options: String?, category: String?) {
        
        Task {
            businesses = await service.businessSearch(userLocation: currentUserLocation,
                                                      query: query,
                                                      options: options,
                                                      category: category)
        }
    }
    
    func getUserLocation() {
        // Check if we have permission
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manaager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        // Detect if user allowed, then request location
        if manager.authorizationStatus == .authorizedWhenInUse {
            currentUserLocation = nil
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if currentUserLocation == nil {
            currentUserLocation = locations.last?.coordinate

            // Call Business Search
            getBusinesses(query: nil, options: nil, category: nil)
        }

        manager.stopUpdatingLocation()
    }
}
