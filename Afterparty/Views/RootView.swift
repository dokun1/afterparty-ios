//
//  HomeView.swift
//  Afterparty
//
//  Created by David Okun on 9/16/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import SwiftUI
import UIKit
import MapKit

struct RootView: View {
  @ObservedObject var viewModel = NearbyEventsViewModel()
  @Environment(\.horizontalSizeClass) var horizontalSizeClass: UserInterfaceSizeClass?

  @State var showList = false
  @State var showProfile = false
  @State var searchTerm = ""
  @State var focusedCoordinates: CLLocationCoordinate2D? = nil
  static let customDetent = UISheetPresentationController.Detent.custom { context in
    return 160
  }
  
  var body: some View {
    MapView(events: viewModel.myEvents)
      .if(horizontalSizeClass == .compact) { view in
        view
          .edgesIgnoringSafeArea([.top, .bottom])
          .detentSheet(isPresented: $showList,
                       largestUndimmedDetentIdentifier: .medium,
                       prefersGrabberVisible: true,
                       detents: [EventSheetSearch.customDetent, .medium(), .large()],
                       allowsDismissalGesture: false) {
            EventSheetSearch(events: $viewModel.myEvents,
                             searchTerm: $searchTerm,
                             showProfile: $showProfile)
          }
          .overlay(alignment: .topTrailing) {
            Button {
              showProfile.toggle()
            } label: {
              Image(systemName: "person.fill")
               .padding()
               .background(.white)
               .frame(width: 42, height: 42)
               .cornerRadius(21)
               .shadow(color: .black, radius: 3)
            }
            .padding(.trailing, 30)
            .padding(.top, 60)
          }
          .task {
            await viewModel.getEvents()
            showList = true
          }
      }
      .if(horizontalSizeClass != .compact) { view in
        view
          .task {
            await viewModel.getEvents()
            showList = false
          }
          .overlay(alignment: .topTrailing) {
            VStack {
              Button {
                showList.toggle()
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
              .popover(isPresented: $showList) {
                EventSheetSearch(events: $viewModel.myEvents,
                                 searchTerm: $searchTerm,
                                 showProfile: .constant(false),
                                 showSearch: false)
                .frame(width: 400, height: 700)
              }
              Button {
                showProfile.toggle()
              } label: {
                Image(systemName: "person.fill")
                  .padding()
                  .background(.white)
                  .frame(width: 42, height: 42)
                  .cornerRadius(21)
                  .shadow(color: .black, radius: 3)
              }
              .padding(.trailing, 30)
              .popover(isPresented: $showProfile) {
                ProfileView()
                  .frame(width: 400, height: 600)
              }
            }
          }
      }.edgesIgnoringSafeArea([.top, .bottom])
  }
}

struct RootView_Previews: PreviewProvider {
  static var previews: some View {
    RootView()
  }
}
