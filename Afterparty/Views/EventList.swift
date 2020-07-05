//
//  EventList.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI
import afterparty_models_swift
import Combine

struct EventList: View {
  @State var events = MockData.sampleEvents
  @ObservedObject var viewModel = MyEventsViewModel()
  
  var body: some View {
    List(self.viewModel.myEvents) { event in
      NavigationLink(destination: EventDetails(event: event)) {
        Text(event.name)
      }
    }.onAppear {
      self.viewModel.getEvents(for: User(email: "david@okun.io"))
    }.alert(item: self.$viewModel.error) { error in
      Alert(title: Text("Network Error"), message: Text(error.localizedDescription), dismissButton: .cancel())
    }
  }
}

struct EventList_Previews: PreviewProvider {
  static var previews: some View {
    EventList()
  }
}
