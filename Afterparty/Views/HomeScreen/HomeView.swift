//
//  ContentView.swift
//  Afterparty
//
//  Created by David Okun on 5/2/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI

struct HomeView: View {
  @State private var selection: NavigationChoice?
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
      }
    } else if UIDevice.current.userInterfaceIdiom == .pad {
      NavigationView {
        Sidebar()
        if let selection = selection {
          selection.view
        } else {
          EmptyView()
        }
        if let selection = selection, selection == .settings || selection == .profile {
          EmptyView()
        } 
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
