//
//  EventList.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI

struct EventList: View {
  @State var events = ["Party 1", "Party 2", "OMG Party"]
    var body: some View {
      List(events, id: \.self) { event in
        Text(event)
      }
    }
}

struct EventList_Previews: PreviewProvider {
    static var previews: some View {
        EventList()
    }
}
