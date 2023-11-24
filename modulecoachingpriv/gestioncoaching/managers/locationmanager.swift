//
//  locationmanager.swift
//  modulecoachingpriv
//
//  Created by Mac-Mini_2021 on 07/11/2023.
//
import CoreLocation
class locatiomanager:NSObject,ObservableObject{
    private let locationmanager = CLLocationManager()
    override init() {
        super.init()
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestWhenInUseAuthorization()
        locationmanager.startUpdatingLocation()
    }
}
extension locatiomanager: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard !locations.isEmpty else {return}
        locationmanager.stopUpdatingLocation()
    }
}
