//
//  NearbyEvents.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI

struct NearbyEvents: View {
  var body: some View {
    NavigationView {
      VStack {
        MapView()
          .frame(height: 200, alignment: .top)
        
        VStack {
          EventList()
        }
      }.navigationBarTitle("Nearby")
    }
  }
}

struct NearbyEvents_Previews: PreviewProvider {
  static var previews: some View {
    NearbyEvents()
  }
}
