//
//  NearbyEvents.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI

struct NearbyEvents: View {
  @ObservedObject var locationManager = LocationManager()
  @State var shouldPresentSettings = false
  
  var body: some View {
    NavigationView {
      VStack {
        MapView()
          .frame(height: 200, alignment: .top)
        VStack {
          EventList()
        }
      }.sheet(isPresented: $shouldPresentSettings) {
        MySettings()
      }
      .navigationBarTitle("Nearby Events")
        .onAppear {
          locationManager.startUpdating()
        }
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              self.shouldPresentSettings = true
            } label: {
              Image(systemName: "gear")
            }
          }
        }
    }
  }
}

struct NearbyEvents_Previews: PreviewProvider {
  static var previews: some View {
    NearbyEvents()
  }
}
