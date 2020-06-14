//
//  EventList.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI
import afterparty_models_swift

struct EventList: View {
  @State var events = MockData.sampleEvents
    var body: some View {
      List(events) { event in
        Text(event.name)
      }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}
