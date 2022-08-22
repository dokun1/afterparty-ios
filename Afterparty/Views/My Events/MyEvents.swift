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
  @State private var shouldShowSettings = false
  
  var body: some View {
    if viewModel.isSignedIn {
      NavigationView {
        List(self.viewModel.myEvents, id: \.name) { event in
          NavigationLink(destination: EventDetails(event: event)) {
            Text(event.name)
          }
        }
        .task {
          await self.viewModel.getSavedEvents()
        }
        .navigationTitle("My Events")
        .alert(item: self.$viewModel.error) { error in
          Alert(title: Text("Network Error"), message: Text(error.localizedDescription), dismissButton: .cancel())
        }
        .refreshable {
          Task {
            await self.viewModel.getSavedEvents()
          }
        }
        .sheet(isPresented: $shouldShowEventCreation) {
          AddEventView()
        }
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              shouldShowEventCreation = true
            } label: {
              Image(systemName: "plus")
            }
          }
        }
      }
    } else {
      NavigationView {
        EmptyMyEventView()
      }
    }
  }
}

struct MyEvents_Previews: PreviewProvider {
  static var previews: some View {
    MyEvents()
  }
}
