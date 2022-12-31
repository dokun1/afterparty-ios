//
//  MapView.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI
import Foundation
import MapKit
import afterparty_models_swift

class EventAnnotation: NSObject, MKAnnotation {
  init(coordinate: CLLocationCoordinate2D) {
    self.coordinate = coordinate
  }
  var coordinate: CLLocationCoordinate2D
}

struct MapView: UIViewRepresentable {
  @State var events: [Event] = [Event]()
//  @Binding var focusedCoordinates: CLLocationCoordinate2D? = nil
  var mapView = MKMapView(frame: UIScreen.main.bounds)
  
  func makeUIView(context: Context) -> MKMapView {
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    drawAnnotations()
    return mapView
  }
  
  func drawAnnotations() {
    var longitudes = [Double]()
    var latitudes = [Double]()
    for event in events {
      if let place = event.place {
        let annotation = EventAnnotation(coordinate: .init(latitude: place.latitude, longitude: place.longitude))
        mapView.addAnnotation(annotation)
        latitudes.append(place.latitude)
        longitudes.append(place.longitude)
      }
    }
    if latitudes.count > 0, longitudes.count > 0 {
      let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      let avgLatitude = latitudes.reduce(0.0, +) / Double(latitudes.count)
      let avgLongitude = longitudes.reduce(0.0, +) / Double(longitudes.count)
      let region = MKCoordinateRegion(center: .init(latitude: avgLatitude, longitude: avgLongitude), span: span)
      mapView.setRegion(region, animated: false)
    }
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
    drawAnnotations()
  }
}


struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView(events: [])
  }
}
