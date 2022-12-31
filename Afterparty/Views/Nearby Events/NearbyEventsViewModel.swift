//
//  NearbyEventsViewModel.swift
//  Afterparty
//
//  Created by David Okun on 8/21/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import Foundation
import afterparty_models_swift

@MainActor
class NearbyEventsViewModel: ObservableObject {
  private let api = AfterpartyAPI(session: MockAPISession())
  @Published var myEvents = [Event]()
  @Published var error: AfterpartyAPI.Error? = nil
  
  var isSignedIn: Bool {
    api.session.isSignedIn
  }

  func getEvents() async {
    do {
      let endpoint = AfterpartyAPI.Endpoint.getEvents
      let eventResponse: EventResponse = try await api.session.makeRequest(using: endpoint)
      self.myEvents = eventResponse.results
    } catch {
      self.myEvents = [Event]()
    }
  }
}
