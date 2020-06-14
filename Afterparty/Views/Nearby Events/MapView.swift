//
//  MapView.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  
  func makeUIView(context: Context) -> MKMapView {
    let mapView = MKMapView(frame: UIScreen.main.bounds)
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
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
