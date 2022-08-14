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
  @State private var shouldShowAddEventView = false
  var body: some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      NavigationView {
        myEventsView
      }.sheet(isPresented: $shouldShowAddEventView) {
        AddEventView()
      }
    } else {
      myEventsView
        .sheet(isPresented: $shouldShowAddEventView) {
          AddEventView()
        }
    }
  }
  
  var myEventsView: some View {
    EventList()
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            self.shouldShowAddEventView = true
          } label: {
            Image(systemName: "plus")
          }
        }
      }
      .navigationBarTitle("My Events")
  }
}



struct MyEvents_Previews: PreviewProvider {
  static var previews: some View {
    MyEvents()
  }
}
