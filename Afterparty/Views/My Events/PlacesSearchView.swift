//
//  PlacesSearchView.swift
//  Afterparty
//
//  Created by David Okun on 7/31/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import SwiftUI
import afterparty_models_swift

struct PlacesSearchView: View {
  @ObservedObject var viewModel = PlacesSearchViewModel()
  @State var eventViewModel: AddEventViewModel
  @State var searchPrompt = ""
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
    var body: some View {
      List(viewModel.displayedPlaces) { place in
        Button {
          self.eventViewModel.currentEvent.place = place
          self.presentationMode.wrappedValue.dismiss()
        } label: {
          VStack(alignment: .leading) {
            HStack {
              Text(place.name)
                .foregroundColor(.primary)
                .font(.headline)
              Spacer()
              Text("\(place.distance, specifier: "%.0f") meters")
                .foregroundColor(.primary)
                .font(.footnote)
            }
            Text(place.fullAddress)
              .foregroundColor(.primary)
              .font(.caption)
          }
        }
      }.task {
        if let coordinate = eventViewModel.locationManager.lastKnownLocation?.coordinate {
          await viewModel.getPlaces(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
      }.searchable(text: $searchPrompt, prompt: "Search by name")
        .onChange(of: searchPrompt) { newValue in
          viewModel.displayedPlaces = newValue.isEmpty ? viewModel.places : viewModel.places.filter { $0.name.contains(newValue) }
        }
        .navigationBarTitle(Text("Places near you"))
    }
}

struct PlacesSearchView_Previews: PreviewProvider {
    static var previews: some View {
      PlacesSearchView(eventViewModel: AddEventViewModel())
    }
}
