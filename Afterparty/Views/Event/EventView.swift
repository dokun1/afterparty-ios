//
//  EventView.swift
//  Afterparty
//
//  Created by David Okun on 8/13/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import SwiftUI
import afterparty_models_swift

struct EventView: View {
  @ObservedObject var viewModel: EventViewModel
  
  init(_ event: Event) {
    self.viewModel = EventViewModel(event: event)
  }
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
        ForEach(0x1f600...0x1f679, id: \.self) { value in
          Text(String(format: "%x", value))
          Text(emoji(value))
            .font(.largeTitle)
        }
      }.navigationTitle(viewModel.eventName)
    }.frame(maxHeight: .infinity)
  }
  
  private func emoji(_ value: Int) -> String {
    guard let scalar = UnicodeScalar(value) else { return "?" }
    return String(Character(scalar))
  }
}



struct EventView_Previews: PreviewProvider {
  static let mockEvent = Event(name: "Mock Event", end: Date().addingTimeInterval(86400))
  static var previews: some View {
    EventView(mockEvent)
  }
}
