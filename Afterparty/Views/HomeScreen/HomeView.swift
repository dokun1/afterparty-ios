//
//  ContentView.swift
//  Afterparty
//
//  Created by David Okun on 5/2/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI
import afterparty_models_swift

struct HomeView: View {
  @State private var selection: NavigationChoice? = .nearbyEvents
  @State private var chosenEvent: Event? = nil
  
  var body: some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      TabView(selection: $selection) {
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
        ProfileView()
          .tabItem {
            Image(systemName: "person.fill")
            Text("Profile")
          }
          .tag(2)
      }
    } else if UIDevice.current.userInterfaceIdiom == .pad {
      NavigationView {
        Sidebar()
        NearbyEvents()
        EmptyEventView()
      }
    }
  }
}

struct EmptyMyEventView: View {
  var body: some View {
    VStack {
      Image(systemName: "person.fill.questionmark")
        .font(.system(size: 100))
      Text("Log in to save some events!")
        .font(.title2)
    }
  }
}

struct EmptyEventView: View {
  var body: some View {
    VStack {
      Text("🎉")
        .font(.system(size: 100))
      Text("Choose a nearby event to get started.")
        .font(.title2)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
