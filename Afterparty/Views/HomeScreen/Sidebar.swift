//
//  Sidebar.swift
//  Afterparty
//
//  Created by David Okun on 8/14/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import SwiftUI
import afterparty_models_swift

enum NavigationChoice: String, CaseIterable {
  case nearbyEvents = "Nearby Events"
  case myEvents = "My Events"
  case profile = "Profile"
  
  func systemImageString(isSelected: Bool) -> String {
    switch self {
      case .nearbyEvents:
        return isSelected ? "location.fill" : "location"
      case .myEvents:
        return isSelected ? "clock.fill" : "clock"
      case .profile:
        return isSelected ? "person.fill" : "person"
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
    }
  }
}

struct Sidebar: View {
  @State var selection: NavigationChoice? = NavigationChoice.nearbyEvents
  @State private var shouldPresentProfile = false
  @State private var shouldPresentEventCreation = false
  @ObservedObject var viewModel = MyEventsViewModel()
  
  var body: some View {
    List {
      NavigationLink(destination: NavigationChoice.nearbyEvents.view,
                     tag: NavigationChoice.nearbyEvents,
                     selection: $selection) {
        Label(NavigationChoice.nearbyEvents.rawValue, systemImage: NavigationChoice.nearbyEvents.systemImageString(isSelected: true))
          .font(.system(size: 20, weight: .bold, design: .default))
      }
      DisclosureGroup {
        ForEach(viewModel.myEvents, id: \.objectId) { event in
          NavigationLink {
            EventDetails(event: event)
          } label: {
            Text(event.name)
              .font(.title3)
          }
        }
      } label: {
        Label("My Events", systemImage: "clock")
          .font(.system(size: 20, weight: .bold, design: .default))
      }
    }
    .listStyle(SidebarListStyle())
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          AfterpartyMenu(profileBinding: $shouldPresentProfile, eventBinding: $shouldPresentEventCreation)
        }
      }
      .sheet(isPresented: $shouldPresentProfile) {
        print("did dismiss profile")
      } content: {
        ProfileView()
      }
      .sheet(isPresented: $shouldPresentEventCreation) {
        print("did dismiss event creation")
      } content: {
        AddEventView()
      }
      .navigationTitle(Text("Afterparty"))
      .task {
        await viewModel.getSavedEvents()
      }
  }
}

struct Sidebar_Previews: PreviewProvider {
  static var previews: some View {
    Sidebar()
  }
}
