//
//  LocationManager.swift
//  Matule
//
//  Created by Вадим Мартыненко on 18.05.2024.
//

import Foundation
import CoreLocation

final class LocationManager {
    static let instance = LocationManager()
    
    private let locationManager = CLLocationManager()
    
    func getLocation() -> CLLocation? {
        return locationManager.location
    }
    
    func geocodeLocation(location: CLLocation, closure: @escaping (_ placemark: CLPlacemark) -> Void) {
        DispatchQueue.global().async {
            CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                guard let placemarks, let placemark = placemarks.first else { return }
                
                DispatchQueue.main.async {
                    closure(placemark)
                }
            }
        }
    }
    
    func geocodeLocationAsync(location: CLLocation) async throws -> CLPlacemark {
        let placemarks = try await CLGeocoder().reverseGeocodeLocation(location)
        
        guard let placemark = placemarks.first else { throw URLError(.badServerResponse) }
        
        return placemark
    }
}
