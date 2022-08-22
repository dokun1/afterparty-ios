//
//  MyEventsViewModel.swift
//  Afterparty
//
//  Created by David Okun on 7/5/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import Foundation
import Combine
import afterparty_models_swift

@MainActor
class MyEventsViewModel: ObservableObject {
  private let api = AfterpartyAPI(session: MockAPISession())
  private var subscriptions = Set<AnyCancellable>()
  @Published var myEvents = [Event]()
  @Published var error: AfterpartyAPI.Error? = nil
  
  var isSignedIn: Bool {
    api.session.isSignedIn
  }
  
  func addEvent(_ event: Event) async {
    do {
      let _: Event = try await api.session.makeRequest(using: AfterpartyAPI.Endpoint.addEvent(event))
      self.myEvents.append(event)
    } catch {
      self.myEvents = [Event]()
    }
  }
  
  func getSavedEvents() async {
    if api.session.isSignedIn {
      do {
        guard let userID = UserDefaults.standard.object(forKey: MockAPISession.mockAuthTokenKey) as? String else {
          throw AfterpartyAPI.Error.notLoggedIn
        }
        let endpoint = AfterpartyAPI.Endpoint.getSavedEvents(userID: userID)
        let eventResponse: EventResponse = try await api.session.makeRequest(using: endpoint)
        self.myEvents = eventResponse.results
      } catch {
        self.myEvents = [Event]()
      }
    } else {
      self.myEvents = [Event]()
      print("not logged in")
    }
  }
}
