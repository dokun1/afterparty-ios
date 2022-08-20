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
  @State var shouldPresentProfile = false
  
  var body: some View {
    if UIDevice.current.userInterfaceIdiom == .pad {
      nearbyEventsView
    } else {
      NavigationView {
        nearbyEventsView
          .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
              Button {
                self.shouldPresentProfile.toggle()
              } label: {
                Image(systemName: "person.circle.fill")
              }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
              Button {
                self.shouldPresentSettings.toggle()
              } label: {
                Image(systemName: "gear")
              }
            }
          }
      }
    }
  }
  
  var nearbyEventsView: some View {
    VStack {
      MapView()
        .frame(height: 200, alignment: .top)
      VStack {
        EventList()
      }
    }.sheet(isPresented: $shouldPresentSettings) {
      SettingsView()
    }.sheet(isPresented: $shouldPresentProfile, content: {
      ProfileView()
    })
    .navigationBarTitle("Nearby Events")
    .onAppear {
      locationManager.startUpdating()
    }
  }
}

struct NearbyEvents_Previews: PreviewProvider {
  static var previews: some View {
    NearbyEvents()
  }
}
