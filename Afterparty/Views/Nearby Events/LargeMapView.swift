//
//  LargeMapView.swift
//  Afterparty
//
//  Created by David Okun on 9/5/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import SwiftUI

struct LargeMapView: View {
  @ObservedObject var viewModel = NearbyEventsViewModel()
  @State var searchTerm = ""
  @State var shouldShowProfile = false
  @State var shouldShowEvents = false
  var body: some View {
    MapView(events: viewModel.myEvents)
      .task {
        await viewModel.getEvents()
      }
      .edgesIgnoringSafeArea([.top, .bottom])
      .overlay(alignment: .topLeading) {
        Text("Afterparty")
          .padding(.leading, 20)
          .padding(.top, 20)
          .font(.largeTitle)
          .foregroundColor(.white)
          .shadow(color: .black, radius: 5)
      }
      .overlay(alignment: .topTrailing) {
        VStack {
          Button {
            shouldShowEvents.toggle()
          } label: {
            Image(systemName: "list.star")
              .padding()
              .background(.white)
              .frame(width: 42, height: 42)
              .cornerRadius(21)
              .shadow(color: .black, radius: 3)
          }
          .padding(.top, 30)
          .padding(.trailing, 30)
          .popover(isPresented: $shouldShowEvents) {
            EventSheetSearch(events: $viewModel.myEvents,
                             searchTerm: $searchTerm,
                             showProfile: .constant(false),
                             showSearch: false)
            .frame(width: 400, height: 700)
          }
          Button {
            shouldShowProfile.toggle()
          } label: {
            Image(systemName: "person.fill")
              .padding()
              .background(.white)
              .frame(width: 42, height: 42)
              .cornerRadius(21)
              .shadow(color: .black, radius: 3)
          }
          .padding(.trailing, 30)
          .popover(isPresented: $shouldShowProfile) {
            ProfileView()
              .frame(width: 300, height: 300)
          }
        }

      }
  }
}

struct LargeMapView_Previews: PreviewProvider {
  static var previews: some View {
    LargeMapView()
  }
}
