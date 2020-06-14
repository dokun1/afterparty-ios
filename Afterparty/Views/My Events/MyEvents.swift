//
//  MyEvents.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI

struct MyEvents: View {
  var body: some View {
    NavigationView {
      EventList()
        .navigationBarItems(trailing:
          Button(action: {
            print("new event button tapped")
          }, label: {
            Image(systemName: "plus")
          })
      )
        .navigationBarTitle("My Events")
    }
    
  }
}

struct MyEvents_Previews: PreviewProvider {
  static var previews: some View {
    MyEvents()
  }
}
