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
  @ObservedObject var viewModel: EventDetailsViewModel
  
  var formatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.timeStyle = .medium
    formatter.dateStyle = .medium
    return formatter
  }
  
  init(event: Event) {
    self.viewModel = EventDetailsViewModel(event: event)
  }
  
  var body: some View {
    VStack {
      Form {
        Section {
          Text("Starts at: \(viewModel.event.start.formatted())")
          Text("Ends at: \(viewModel.event.end.formatted())")
        }
        Section("Location") {
          if let place = viewModel.event.place {
            Label(place.name, systemImage: "mappin.circle")
          } else {
            Label("No place specified!", systemImage: "xmark.octagon")
          }
          MapView(event: viewModel.event).frame(height: 200, alignment: .top)
        }
        Section("Description") {
          Text(viewModel.event.description)
        }
        Section {
          Button {
            Task {
              try await viewModel.saveEvent()
            }
          } label: {
            Label("Save Event", systemImage: "square.and.arrow.down")
          }
          NavigationLink {
            EventView(viewModel.event)
          } label: {
            Label("Join Event", systemImage: "person.badge.plus")
          }
        }
      }
    }
    .navigationBarTitle(viewModel.event.name, displayMode: .large)
  }
}

struct EventDetails_Previews: PreviewProvider {
  static var previews: some View {
    EventDetails(event: MockData.sampleEvents.first!)
  }
}
