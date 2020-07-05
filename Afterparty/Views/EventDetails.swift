//
//  EventDetails.swift
//  Afterparty
//
//  Created by David Okun on 7/5/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI
import afterparty_models_swift

struct EventDetails: View {
  var event: Event
  var formatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .medium
    return formatter
  }
  
  var body: some View {
    NavigationView {
      VStack {
        MapView(event: event).frame(height: 200, alignment: .top)
        Form {
          Section(header: Text("Start Time")) {
            Text(formatter.string(from: event.start))
          }
          Section(header: Text("End Time")) {
            Text(formatter.string(from: event.end))
          }
        }
      }
    }.navigationBarTitle(event.name)
  }
}

struct EventDetails_Previews: PreviewProvider {
  static var previews: some View {
    EventDetails(event: MockData.sampleEvents.first!)
  }
}
