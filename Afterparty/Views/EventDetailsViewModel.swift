//
//  EventDetailsViewModel.swift
//  Afterparty
//
//  Created by David Okun on 8/21/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import Foundation
import afterparty_models_swift

@MainActor
class EventDetailsViewModel: ObservableObject {
  private let api = AfterpartyAPI(session: MockAPISession())
  @Published var error: AfterpartyAPI.Error? = nil
  let event: Event
  
  init(event: Event) {
    self.event = event
  }
  
  func saveEvent() async throws {
    do {
      guard let userID = UserDefaults.standard.object(forKey: MockAPISession.mockAuthTokenKey) as? String else {
        throw AfterpartyAPI.Error.notLoggedIn
      }
      let endpoint = AfterpartyAPI.Endpoint.saveEvent(event, userID: userID)
      let response: EventAdditionResponse = try await api.session.makeRequest(using: endpoint)
      print("response: \(response)")
    } catch {
      self.error = error as? AfterpartyAPI.Error
    }
  }
}
