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
  
  func addEvent(_ event: Event) async {
    do {
      let _: Event = try await api.session.makeRequest(using: AfterpartyAPI.Endpoint.addEvent(event))
      self.myEvents.append(event)
    } catch {
      self.myEvents = [Event]()
    }
  }
  
  func getEvents(for user: User) async {
    do {
      let eventResponse: EventResponse = try await api.session.makeRequest(using: AfterpartyAPI.Endpoint.getEvents)
      self.myEvents = eventResponse.results
    } catch {
      self.myEvents = [Event]()
    }
  }
}
