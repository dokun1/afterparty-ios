//
//  API.swift
//  Afterparty
//
//  Created by David Okun on 7/5/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import Foundation
import Combine
import afterparty_models_swift

protocol NetworkSession {
  func makeRequest<D: Decodable>(using endpoint: AfterpartyAPI.Endpoint) async throws -> D
  var isSignedIn: Bool { get }
}

extension URLSession: NetworkSession {
  func makeRequest<D: Decodable>(using endpoint: AfterpartyAPI.Endpoint) async throws -> D {
    print("***making real request***")
    do {
      let (data, response) = try await self.data(for: endpoint.request)
      if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode > 399 {
        throw AfterpartyAPI.Error.invalidResponse
      }
      let decoded = try JSONDecoder().decode(D.self, from: data)
      return decoded
    } catch {
      print(error)
      throw error
    }
  }
  
  var isSignedIn: Bool {
    !(UserDefaults.standard.object(forKey: MockAPISession.mockAuthTokenKey) as? String ?? "").isEmpty
  }
}

class AfterpartyAPI {
  init(session: NetworkSession = URLSession(configuration: .default)) {
    self.session = session
    Task {
      for await _ in NotificationCenter.default.notifications(named: .init(MockAPISession.useMockKey)) {
        if UserDefaults.standard.bool(forKey: MockAPISession.useMockKey) {
          self.session = MockAPISession()
        } else {
          self.session = URLSession(configuration: .default)
        }
      }
    }
  }
  
  var session: NetworkSession
  
  enum Error: LocalizedError, Identifiable {
    var id: String { localizedDescription }
    
    case addressUnreachable(URL)
    case invalidResponse
    case couldNotFindMockFile(String)
    case notLoggedIn
    
    var errorDescription: String? {
      switch self {
        case .addressUnreachable(let url): return "\(url.absoluteString) is not reachable."
        case .invalidResponse: return "The server response is invalid."
        case .couldNotFindMockFile(let fileName): return "No mock file found named \(fileName)"
        case .notLoggedIn: return "Not logged in"
      }
    }
  }
  
  fileprivate enum ParseDetails {
    static let headerKey = "X-Parse-Application-Id"
  }
  
  fileprivate enum FoursquareDetails {
    static let rootURL = "https://api.foursquare.com"
    static let radius = "radius"
    static let latLong = "ll"
    static let limit = "limit"
    static let defaultLimit = "30"
  }
  
  fileprivate enum APIPaths {
    static let getEvents = "parse/classes/afterpartyEvents"
    static let addEvents = "parse/classes/afterpartyEvents"
    static func saveEvent(userID: String) -> String { return "parse/classes/users/\(userID)" }
    static func getSavedEvents(userID: String) -> String { return "parse/classes/users/\(userID)/events" }
    static let getPlaces = "/v3/places/search"
  }
  
  fileprivate enum RequestDetails {
    static let contentTypeHeaderKey = "Content-Type"
    static let applicationJSON = "application/json"
    static let acceptHeaderKey = "Accept"
    static let authorizationHeaderKey = "Authorization"
    static let httpScheme = "http"
    static let httpsScheme = "https"
    static let userID: String = {
      if let id = UserDefaults.standard.object(forKey: MockAPISession.mockAuthTokenKey) as? String {
        return id
      } else {
        return ""
      }
    }()
  }
  
  fileprivate enum RequestTypes {
    static let get = "GET"
    static let post = "POST"
    static let put = "PUT"
  }
  
  enum Endpoint {
    case getEvents
    case addEvent(Event)
    case saveEvent(Event, userID: String)
    case getSavedEvents(userID: String)
    case foursquareGetLocations(latitude: Double, longitude: Double, query: String?, radius: Int)
    
    var url: URL {
      switch self {
        case .getEvents:
          return EnvironmentVariables.rootURL.appendingPathComponent(APIPaths.getEvents)
        case .addEvent:
          return EnvironmentVariables.rootURL.appendingPathComponent(APIPaths.addEvents)
        case .saveEvent(_, let userID):
          return EnvironmentVariables
            .rootURL
            .appendingPathComponent(APIPaths.saveEvent(userID: userID))
        case .getSavedEvents(let userID):
          return EnvironmentVariables
            .rootURL
            .appendingPathComponent(APIPaths.getSavedEvents(userID: userID))
        case .foursquareGetLocations(let latitude, let longitude, _, let radius):
          var queryItems = [URLQueryItem]()
          queryItems.append(.init(name: FoursquareDetails.radius, value: "\(radius)"))
          queryItems.append(.init(name: FoursquareDetails.latLong, value: "\(latitude),\(longitude)"))
          queryItems.append(.init(name: FoursquareDetails.limit, value: FoursquareDetails.defaultLimit))
          guard var components = URLComponents(string: FoursquareDetails.rootURL) else {
            fatalError("Could not construct foursquare API")
          }
          components.queryItems = queryItems
          components.path = APIPaths.getPlaces
          components.scheme = RequestDetails.httpsScheme
          guard let url = components.url else {
            fatalError("Could not construct foursquare API")
          }
          return url
      }
    }
    
    var request: URLRequest {
      switch self {
        case .getEvents:
          var request = URLRequest(url: Endpoint.getEvents.url)
          request.httpMethod = RequestTypes.get
          request.allHTTPHeaderFields = [
            RequestDetails.contentTypeHeaderKey: RequestDetails.applicationJSON,
            ParseDetails.headerKey: EnvironmentVariables.parseApplicationID
          ]
          
          return request
        case .foursquareGetLocations(let latitude, let longitude, let query, let radius):
          var request = URLRequest(url: Endpoint.foursquareGetLocations(latitude: latitude, longitude: longitude, query: query, radius: radius).url)
          request.httpMethod = RequestTypes.get
          request.allHTTPHeaderFields = [
            RequestDetails.acceptHeaderKey: RequestDetails.applicationJSON,
            RequestDetails.authorizationHeaderKey: EnvironmentVariables.foursquareAPIKey
          ]
          return request
        case .addEvent(let event):
          var request = URLRequest(url: Endpoint.addEvent(event).url)
          request.allHTTPHeaderFields = [
            RequestDetails.contentTypeHeaderKey: RequestDetails.applicationJSON,
            ParseDetails.headerKey: EnvironmentVariables.parseApplicationID
          ]
          request.httpMethod = RequestTypes.post
          request.httpBody = try! JSONEncoder().encode(event)
          return request
        case .saveEvent(let event, let userID):
          var request = URLRequest(url: Endpoint.saveEvent(event, userID: userID).url)
          request.allHTTPHeaderFields = [
            RequestDetails.contentTypeHeaderKey: RequestDetails.applicationJSON,
            ParseDetails.headerKey: EnvironmentVariables.parseApplicationID
          ]
          request.httpMethod = RequestTypes.put
          let eventToAdd = ["savedEvents": event.objectId]
          request.httpBody = try! JSONEncoder().encode(eventToAdd)
          return request
        case .getSavedEvents(let userID):
          var request = URLRequest(url: Endpoint.getSavedEvents(userID: userID).url)
          request.allHTTPHeaderFields = [
            RequestDetails.contentTypeHeaderKey: RequestDetails.applicationJSON,
            ParseDetails.headerKey: EnvironmentVariables.parseApplicationID
          ]
          request.httpMethod = RequestTypes.get
          return request
      }
    }
  }
}
