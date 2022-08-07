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
}

class AfterpartyAPI {
  init(session: NetworkSession = URLSession(configuration: .default)) {
    self.session = session
    if UserDefaults.standard.bool(forKey: MockAPISession.useMockKey) {
      self.session = MockAPISession()
    }
  }
  
  var session: NetworkSession
  
  enum Error: LocalizedError, Identifiable {
    var id: String { localizedDescription }
    
    case addressUnreachable(URL)
    case invalidResponse
    case couldNotFindMockFile(String)
    
    var errorDescription: String? {
      switch self {
        case .addressUnreachable(let url): return "\(url.absoluteString) is not reachable."
        case .invalidResponse: return "The server response is invalid."
        case .couldNotFindMockFile(let fileName): return "No mock file found named \(fileName)"
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
    static let getPlaces = "/v3/places/search"
  }
  
  fileprivate enum RequestDetails {
    static let contentTypeHeaderKey = "Content-Type"
    static let applicationJSON = "application/json"
    static let acceptHeaderKey = "Accept"
    static let authorizationHeaderKey = "Authorization"
    static let httpScheme = "http"
    static let httpsScheme = "https"
  }
  
  fileprivate enum RequestTypes {
    static let get = "GET"
    static let post = "POST"
  }
  
  enum Endpoint {
    case getEvents
    case addEvent(Event)
    case foursquareGetLocations(latitude: Double, longitude: Double, query: String?, radius: Int) // latitude, longitude, optional query, radius
    
    var url: URL {
      switch self {
        case .getEvents:
          return EnvironmentVariables.rootURL.appendingPathComponent(APIPaths.getEvents)
        case .addEvent:
          return EnvironmentVariables.rootURL.appendingPathComponent(APIPaths.addEvents)
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
      }
    }
  }
}
