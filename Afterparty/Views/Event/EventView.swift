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
  
  var narrowColumns = [GridItem(.flexible()), GridItem(.flexible())]
  var wideColumns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: UIDevice.current.userInterfaceIdiom == .phone ? narrowColumns : wideColumns) {
        ForEach(1...100, id: \.self) { value in
          if let url = URL(string: "https://dummyimage.com/150x90/ffffff/037dae.png&text=Image\(value)") {
            AsyncImage(url: url)
          }
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
