//
//  MySettings.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI

struct MySettings: View {
  var body: some View {
    NavigationView {
      List {
        Section(header: Text("User")) {
          HStack {
            Image("person.image.fill")
            Text("Cell 1")
          }
          Text("Cell 2")
          Toggle(isOn: .constant(true)) {
            Text("Cell 3")
          }
        }
        Section(header: Text("Events")) {
          Text("Cell 4")
          Text("Cell 5")
          Text("Cell 6")
        }
      }.listStyle(GroupedListStyle()).navigationBarTitle("Settings")
    }
  }
}

struct MySettings_Previews: PreviewProvider {
  static var previews: some View {
    MySettings()
  }
}
