//
//  ContentView.swift
//  Afterparty
//
//  Created by David Okun on 5/2/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  @State private var selection = 0
  
  var body: some View {
    TabView(selection: $selection){
      NearbyEvents()
        .tabItem {
          Image(systemName: "location.fill")
          Text("Nearby Events")
      }
      .tag(0)
      MyEvents()
        .tabItem {
          Image(systemName: "clock.fill")
          Text("My Events")
      }
      .tag(1)
      MySettings()
        .tabItem {
          Image(systemName: "person.fill")
          Text("Settings")
      }
      .tag(2)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
