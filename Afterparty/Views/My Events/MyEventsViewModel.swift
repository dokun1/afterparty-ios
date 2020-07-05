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

class MyEventsViewModel: ObservableObject {
  private let api = AfterpartyAPI()
  private var subscriptions = Set<AnyCancellable>()
  @Published var myEvents = [Event]()
  @Published var error: AfterpartyAPI.Error? = nil
  
  func getEvents(for user: User) {
    print("Fetching events for \(user.nickname)")
    api.getMockEvents()
      .receive(on: DispatchQueue.main)
      .sink(receiveCompletion: { completion in
        print("request complete")
        if case .failure(let error) = completion {
          print("received error with reason: \(error.localizedDescription)")
          self.myEvents = [Event]()
          self.error = error
        }
      }, receiveValue: { events in
        self.myEvents = events
        self.error = nil
      })
      .store(in: &subscriptions)
  }
}
