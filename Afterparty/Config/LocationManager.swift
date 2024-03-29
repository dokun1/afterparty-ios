//
//  LocationManager.swift
//  Afterparty
//
//  Created by David Okun on 8/6/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
  private let manager = CLLocationManager()
  @Published var lastKnownLocation: CLLocation?
  
  func startUpdating() {
    manager.delegate = self
    manager.requestWhenInUseAuthorization()
    manager.startUpdatingLocation()
  }
  
  func stopUpdating() {
    manager.stopUpdatingLocation()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let latest = locations.last else { return }
    lastKnownLocation = latest
  }
  
  func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    if status == .authorizedWhenInUse {
      manager.startUpdatingLocation()
    }
  }
}
