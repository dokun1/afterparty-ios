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
  private let api = AfterpartyAPI()
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
  
  func getEvents() async {
    if api.session.isSignedIn {
      do {
        let eventResponse: EventResponse = try await api.session.makeRequest(using: AfterpartyAPI.Endpoint.getEvents)
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
