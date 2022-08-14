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
    VStack {
      Form {
        Section {
          Text("Starts at: \(event.start.formatted())")
          Text("Ends at: \(event.end.formatted())")
        }
        Section("Location") {
          if let place = event.place {
            Label(place.name, systemImage: "mappin.circle")
          } else {
            Label("No place specified!", systemImage: "xmark.octagon")
          }
          MapView(event: event).frame(height: 200, alignment: .top)
        }
        Section("Description") {
          Text(event.description)
        }
        Section {
          NavigationLink {
            EventView(event)
          } label: {
            Label("Join Event", systemImage: "person.badge.plus")
          }
        }
      }
    }.navigationBarTitle(event.name, displayMode: .large)
  }
}

struct EventDetails_Previews: PreviewProvider {
  static var previews: some View {
    EventDetails(event: MockData.sampleEvents.first!)
  }
}
