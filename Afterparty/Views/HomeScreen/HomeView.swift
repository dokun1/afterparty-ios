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
    if UIDevice.current.userInterfaceIdiom == .phone {
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
      }
    } else if UIDevice.current.userInterfaceIdiom == .pad {
      NavigationView {
        List {
          NavigationLink {
            NearbyEvents()
          } label: {
            Label("Nearby Events", systemImage: "location")
          }
          NavigationLink {
            MyEvents()
          } label: {
            Label("My Events", systemImage: "clock")
          }
        }.listStyle(.sidebar)
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
