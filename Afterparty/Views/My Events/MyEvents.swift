//
//  MyEvents.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI

struct MyEvents: View {
  @State private var shouldShowAlert = false
  var body: some View {
    NavigationView {
      EventList()
        .navigationBarItems(trailing:
          Button(action: {
            self.shouldShowAlert = true
          }, label: {
            Image(systemName: "plus")
          })
      )
        .navigationBarTitle("My Events")
    }.alert(isPresented: $shouldShowAlert) {
      Alert(title: Text("Debug Information"),
            message: Text("""
              root url scheme: \(EnvironmentVariables.rootURLScheme)
              root url host: \(EnvironmentVariables.rootURLHost)
              root url port: \(EnvironmentVariables.rootURLPort)
              full root url: \(String(EnvironmentVariables.rootURL.absoluteString))
              """),
            dismissButton: .cancel())
    }
    
  }
}

struct MyEvents_Previews: PreviewProvider {
  static var previews: some View {
    MyEvents()
  }
}
