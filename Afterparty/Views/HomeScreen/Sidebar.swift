//
//  Sidebar.swift
//  Afterparty
//
//  Created by David Okun on 8/14/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import SwiftUI

enum NavigationChoice: String, CaseIterable {
  case nearbyEvents = "Nearby Events"
  case myEvents = "My Events"
  
  func systemImageString(isSelected: Bool) -> String {
    switch self {
    case .nearbyEvents:
      return isSelected ? "location.fill" : "location"
    case .myEvents:
      return isSelected ? "clock.fill" : "clock"
    }
  }
  
  var systemImageString: String {
    switch self {
    case .nearbyEvents:
      return "location.fill"
    case .myEvents:
      return "clock.fill"
    }
  }
  
  @ViewBuilder var view: some View {
    switch self {
    case .nearbyEvents:
      NearbyEvents()
    case .myEvents:
      MyEvents()
    }
  }
}

struct Sidebar: View {
  @State private var selection: NavigationChoice?
  @State private var shouldPresentSettings = false
  @State private var shouldPresentProfile = false
  
  var body: some View {
    List(NavigationChoice.allCases, id: \.rawValue) { choice in
      NavigationLink(destination: choice.view,
                     tag: choice,
                     selection: $selection) {
        Label(choice.rawValue, systemImage: choice.systemImageString(isSelected: selection == choice))
      }
    }.listStyle(SidebarListStyle())
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          AfterpartyMenu(profileBinding: $shouldPresentProfile, settingsBinding: $shouldPresentSettings)
        }
      }
      .sheet(isPresented: $shouldPresentProfile) {
        print("did dismiss profile")
      } content: {
        ProfileView()
      }
      .sheet(isPresented: $shouldPresentSettings) {
        print("did dismiss settings")
      } content: {
        SettingsView()
      }
      .navigationTitle(Text("Afterparty"))

  }
}

struct Sidebar_Previews: PreviewProvider {
  static var previews: some View {
    Sidebar()
  }
}
