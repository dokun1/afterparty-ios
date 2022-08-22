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
  @State var shouldPresentEventCreation: Binding<Bool>
  
  init(profileBinding: Binding<Bool>, eventBinding: Binding<Bool>) {
    self.shouldPresentProfile = profileBinding
    self.shouldPresentEventCreation = eventBinding
  }
  
  var body: some View {
    Menu {
      Button {
        shouldPresentEventCreation.wrappedValue = true
      } label: {
        Label("Add Event", systemImage: "plus")
      }
      Button {
        shouldPresentProfile.wrappedValue = true
      } label: {
        Label("Profile", systemImage: "person.fill")
      }
    } label: {
      Image(systemName: "ellipsis.circle")
    }
  }
}

struct AfterpartyMenu_Previews: PreviewProvider {
  static var previews: some View {
    AfterpartyMenu(profileBinding: .constant(false), eventBinding: .constant(false))
  }
}
