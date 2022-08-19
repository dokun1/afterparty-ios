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
  case profile = "Profile"
  case settings = "Settings"
  
  func systemImageString(isSelected: Bool) -> String {
    switch self {
      case .nearbyEvents:
        return isSelected ? "location.fill" : "location"
      case .myEvents:
        return isSelected ? "clock.fill" : "clock"
      case .profile:
        return isSelected ? "person.fill" : "person"
      case .settings:
        return isSelected ? "gear.circle.fill" : "gear.circle"
    }
  }
  
  var systemImageString: String {
    switch self {
      case .nearbyEvents:
        return "location.fill"
      case .myEvents:
        return "clock.fill"
      case .profile:
        return "person.fill"
      case .settings:
        return "gear.circle.fill"
    }
  }
  
  @ViewBuilder var view: some View {
    switch self {
      case .nearbyEvents:
        NearbyEvents()
      case .myEvents:
        MyEvents()
      case .profile:
        ProfileView()
      case .settings:
        MySettings()
    }
  }
}

struct Sidebar: View {
  @State private var selection: NavigationChoice?
  var body: some View {
    List(NavigationChoice.allCases, id: \.rawValue) { choice in
      NavigationLink(destination: choice.view,
                     tag: choice,
                     selection: $selection) {
        Label(choice.rawValue, systemImage: choice.systemImageString(isSelected: selection == choice))
      }
    }.listStyle(SidebarListStyle())
  }
}

struct Sidebar_Previews: PreviewProvider {
  static var previews: some View {
    Sidebar()
  }
}
