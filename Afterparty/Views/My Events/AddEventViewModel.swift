//
//  AddEventViewModel.swift
//  Afterparty
//
//  Created by David Okun on 8/6/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import Foundation
import Combine
import afterparty_models_swift

@MainActor
class AddEventViewModel: ObservableObject {
  private let api = AfterpartyAPI()
  var locationManager = LocationManager()
  @Published var currentEvent = Event()
  @Published var error: AfterpartyAPI.Error? = nil
  
  init() {
    self.locationManager.startUpdating()
  }
  
  func submitEvent() async throws {
    do {
      let endpoint = AfterpartyAPI.Endpoint.addEvent(currentEvent)
      let response: EventSubmissionResponse = try await api.session.makeRequest(using: endpoint)
      self.currentEvent.objectId = response.objectId
    } catch {
      self.error = error as? AfterpartyAPI.Error
    }
  }
}
