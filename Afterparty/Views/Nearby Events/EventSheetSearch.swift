//
//  SwiftUIView.swift
//  Afterparty
//
//  Created by David Okun on 8/27/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import SwiftUI
import Foundation
import UIKit
import afterparty_models_swift

struct EventSheetSearch: View {
  @Binding var events: [Event]
  @Binding var searchTerm: String
  @Binding var showProfile: Bool
  @State var chosenEvent: Event?
  @State var showSpecificEvent = false
  var showSearch = true
  static let customDetent = UISheetPresentationController.Detent.custom { context in
    return 100
  }
  @State private var filteredEvents: [Event] = [Event]()
  
  var body: some View {
    NavigationStack {
      VStack(alignment: .leading) {
        List(filteredEvents, id: \.name) { event in
          NavigationLink {
            EventDetails(event: event)
          } label: {
            Text(event.name)
          }
        }
        .searchable(text: $searchTerm, placement: .navigationBarDrawer(displayMode: .always))
        .task {
          filteredEvents = events
        }
        .onChange(of: searchTerm) { searchTerm in
          if !searchTerm.isEmpty {
              filteredEvents = events.filter { $0.name.contains(searchTerm) }
          } else {
              filteredEvents = events
          }
        }
        .sheet(isPresented: $showProfile) {
          ProfileView()
        }
      }.navigationTitle("What are you searching for?")
        .navigationBarTitleDisplayMode(.inline)
    }
  }
}

