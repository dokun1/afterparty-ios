//
//  AfterpartyMenu.swift
//  Afterparty
//
//  Created by David Okun on 8/20/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import SwiftUI

struct AfterpartyMenu: View {
  @State var shouldPresentProfile: Binding<Bool>
  @State var shouldPresentSettings: Binding<Bool>
  @State var shouldPresentEventCreation: Binding<Bool>?
  
  init(profileBinding: Binding<Bool>, settingsBinding: Binding<Bool>, eventBinding: Binding<Bool>? = nil) {
    self.shouldPresentProfile = profileBinding
    self.shouldPresentSettings = settingsBinding
    self.shouldPresentEventCreation = eventBinding
  }
  
  var body: some View {
    Menu {
      Button {
        shouldPresentProfile.wrappedValue = true
      } label: {
        Label("Profile", systemImage: "person.fill")
      }
      Button {
        shouldPresentSettings.wrappedValue = true
      } label: {
        Label("Settings", systemImage: "gear.circle.fill")
      }
    } label: {
      Image(systemName: "ellipsis.circle")
    }
  }
}

struct AfterpartyMenu_Previews: PreviewProvider {
  static var previews: some View {
    AfterpartyMenu(profileBinding: .constant(false), settingsBinding: .constant(false))
  }
}
