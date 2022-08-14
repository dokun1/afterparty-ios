//
//  EventViewModel.swift
//  Afterparty
//
//  Created by David Okun on 8/13/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import Foundation
import Combine
import afterparty_models_swift

@MainActor
class EventViewModel: ObservableObject {
  private let api = AfterpartyAPI()
  private var subscriptions = Set<AnyCancellable>()
  @Published var error: AfterpartyAPI.Error? = nil
  
  private let event: Event
  
  init(event: Event) {
    self.event = event
  }
  
  var isSignedIn: Bool {
    api.session.isSignedIn
  }
  
  var eventName: String {
    event.name
  }
  
  func getPhotos() async {
    print("get photos called for event: \(event.objectId)")
  }
  
  func addPhoto(_ photo: Data) async {
    print("add photo called to event: \(event.objectId)")
  }
}
