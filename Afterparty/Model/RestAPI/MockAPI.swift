//
//  MockAPI.swift
//  Afterparty
//
//  Created by David Okun on 8/6/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import Foundation

class MockAPISession: NetworkSession {
  static let useMockKey = "useMockAPI"
  static let mockUsernameKey = "mockUsername"
  static let mockEmailKey = "mockEmail"
  static let mockAuthTokenKey = "mockAuthToken"
    
  static func randomString(length: Int) -> String {
    let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    return String((0..<length).map{ _ in letters.randomElement()! })
  }
  
  private func getData<D: Decodable>(for fileName: String) throws -> D {
    print("***making mock request***")
    guard let mockResponsePath = Bundle.main.path(forResource: fileName, ofType: "json") else {
      throw AfterpartyAPI.Error.couldNotFindMockFile(fileName)
    }
    do {
      let url = URL(fileURLWithPath: mockResponsePath)
      let data = try Data(contentsOf: url, options: .mappedIfSafe)
      let decoded = try JSONDecoder().decode(D.self, from: data)
      return decoded
    } catch {
      throw error
    }
  }
  
  func makeRequest<D: Decodable>(using endpoint: AfterpartyAPI.Endpoint) async throws -> D {
    do {
      switch endpoint {
        case .getEvents: return try getData(for: "GetEventsMockResponse")
        case .addEvent: return try getData(for: "AddEventMockResponse")
        case .foursquareGetLocations: return try getData(for: "GetPlacesMockResponse")
      }
    } catch {
      throw error
    }
  }
  
  var isSignedIn: Bool {
    !(UserDefaults.standard.object(forKey: MockAPISession.mockAuthTokenKey) as? String ?? "").isEmpty
  }
}
