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
  var event: Event?
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView(frame: UIScreen.main.bounds)
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    if let event = event, let place = event.place {
      let annotation = EventAnnotation(coordinate: .init(latitude: place.latitude, longitude: place.longitude))
      mapView.addAnnotation(annotation)
      let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
      let region = MKCoordinateRegion(center: .init(latitude: place.latitude, longitude: place.longitude), span: span)
      mapView.setRegion(region, animated: false)
    }
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
  }
}


struct MapView_Previews: PreviewProvider {
  static var previews: some View {
    MapView()
  }
}
