//
//  NearbyEvents.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI
import afterparty_models_swift

struct NearbyEvents: View {
  @State var events = MockData.sampleEvents
  @ObservedObject var viewModel = NearbyEventsViewModel()
  @ObservedObject var locationManager = LocationManager()
  @State var shouldPresentSettings = false
  @State var shouldPresentProfile = false
  
  var body: some View {
    if UIDevice.current.userInterfaceIdiom == .pad {
      nearbyEventsView
        .onDisappear {
          locationManager.stopUpdating()
        }
    } else {
      NavigationView {
        nearbyEventsView
          .onDisappear {
            locationManager.stopUpdating()
          }
      }
    }
  }
  
  var nearbyEventsView: some View {
    List {
      Section {
        MapView()
      }.frame(height: 200, alignment: .top)
      Section {
        ForEach(self.viewModel.myEvents, id: \.name) { event in
          NavigationLink(destination: EventDetails(event: event)) {
            Text(event.name)
          }
        }
      }
    }
    .alert(item: self.$viewModel.error) { error in
        Alert(title: Text("Network Error"), message: Text(error.localizedDescription), dismissButton: .cancel())
    }
    .task {
      await self.viewModel.getEvents()
    }
    .refreshable {
      Task {
        await self.viewModel.getEvents()
      }
    }
    .sheet(isPresented: $shouldPresentProfile) {
      ProfileView()
    }
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
