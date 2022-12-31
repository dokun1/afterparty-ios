//
//  PlacesSearchViewModel.swift
//  Afterparty
//
//  Created by David Okun on 7/31/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import Foundation
import Combine
import afterparty_models_swift

@MainActor
class PlacesSearchViewModel: ObservableObject {
  private let api = AfterpartyAPI(session: MockAPISession())
//  private let api = AfterpartyAPI()
  private var subscriptions = Set<AnyCancellable>()
  @Published var places = [Place]() {
    didSet {
      self.displayedPlaces = places
    }
  }
  var displayedPlaces = [Place]()
  @Published var error: AfterpartyAPI.Error? = nil
  
  func getPlaces(latitude: Double, longitude: Double, query: String? = nil, radius: Int = 500) async {
    do {
      let endpoint = AfterpartyAPI.Endpoint.foursquareGetLocations(
        latitude: latitude,
        longitude: longitude,
        query: query,
        radius: radius
      )
      let placesResponse: PlacesResponse = try await api.session.makeRequest(using: endpoint)
      self.places = placesResponse.results
    } catch let error {
      self.error = error as? AfterpartyAPI.Error
    }
  }
}
