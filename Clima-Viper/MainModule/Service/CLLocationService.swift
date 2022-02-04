//
//  CLLocationServiceImp.swift
//  Clima-Viper
//
//  Created by Macbook on 3.02.22.
//

import UIKit
import CoreLocation

class CLLocationService {
    
    func getCoordinateFrom(address: String, completion: @escaping (CLLocationCoordinate2D?, Error?) -> ()) {
        CLGeocoder().geocodeAddressString(address) {
            completion($0?.first?.location?.coordinate, $1)
        }
    }
    
    func getAddressFrom(location: CLLocation, completion: @escaping ([CLPlacemark]?, Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { place, error in
            completion(place, error)
        }
    }
}
