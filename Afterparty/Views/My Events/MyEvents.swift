//
//  MyEvents.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI
import afterparty_models_swift

struct MyEvents: View {
  @ObservedObject var viewModel = MyEventsViewModel()
  @State private var shouldShowAlert = false
  @State private var shouldShowEventCreation = false
  @State private var shouldShowProfile = false
  @State private var shouldShowSettings = false
  var body: some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      NavigationView {
        myEventsView
      }.sheet(isPresented: $shouldShowEventCreation) {
        AddEventView()
      }
    } else {
      myEventsView
        .sheet(isPresented: $shouldShowEventCreation) {
          AddEventView()
        }
    }
  }
  
  @ViewBuilder var myEventsView: some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      EventList()
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              shouldShowEventCreation = true
            } label: {
              Image(systemName: "plus")
            }
          }
        }
        .navigationBarTitle("My Events")
    } else {
      EventList()
        .toolbar {
          ToolbarItem(placement: .primaryAction) {
            AfterpartyMenu(profileBinding: $shouldShowProfile,
                           settingsBinding: $shouldShowSettings,
                           eventBinding: $shouldShowEventCreation)
          }
        }
        .navigationBarTitle("My Events")
    }
  }
}



struct MyEvents_Previews: PreviewProvider {
  static var previews: some View {
    MyEvents()
  }
}
