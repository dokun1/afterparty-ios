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

class AfterpartyAPI {
  private var session = URLSession(configuration: .default)
  private let apiQueue = DispatchQueue(label: "AfterpartyAPI", qos: .default, attributes: .concurrent)
  private let decoder = JSONDecoder()
  
  private static let timeoutInterval = 10.0
  
  enum Error: LocalizedError, Identifiable {
    var id: String { localizedDescription }
    
    case addressUnreachable(URL)
    case invalidResponse
    
    var errorDescription: String? {
      switch self {
        case .addressUnreachable(let url): return "\(url.absoluteString) is not reachable."
        case .invalidResponse: return "The server response is invalid."
      }
    }
  }
  
  enum Endpoint {
    case mockEvents
    case mockUsers
    case mockLocations
    case hello(String?)
    
    fileprivate var url: URL {
      switch self {
        case .hello(let name):
          if let name = name {
            return EnvironmentVariables.rootURL.appendingPathComponent("hello").appendingPathComponent(name)
          } else {
            return EnvironmentVariables.rootURL.appendingPathComponent("hello")
          }
        case .mockEvents:
          return EnvironmentVariables.rootURL.appendingPathComponent("mockEvents")
        case .mockUsers:
          return EnvironmentVariables.rootURL.appendingPathComponent("mockUsers")
        case .mockLocations:
          return EnvironmentVariables.rootURL.appendingPathComponent("mockLocations")
      }
    }
    
    var request: URLRequest {
      switch self {
        case .hello(let name):
          var request = URLRequest(url: Endpoint.hello(name).url)
          request.httpMethod = "GET"
          return request
        case .mockUsers:
          var request = URLRequest(url: Endpoint.mockUsers.url)
          request.httpMethod = "GET"
          return request
        case .mockLocations:
          var request = URLRequest(url: Endpoint.mockLocations.url)
          request.httpMethod = "GET"
          return request
        case .mockEvents:
          var request = URLRequest(url: Endpoint.mockEvents.url)
          request.httpMethod = "GET"
          return request
      }
    }
  }
  
  func getHelloResponse(for name: String?) -> AnyPublisher<String, Error> {
    session.dataTaskPublisher(for: Endpoint.hello(name).request)
      .receive(on: apiQueue)
      .map { $0.data }
      .decode(type: String.self, decoder: decoder)
      .mapError { error in
        switch error {
          case is URLError:
            return Error.addressUnreachable(Endpoint.hello(name).url)
          default:
            return Error.invalidResponse
        }
      }
      .eraseToAnyPublisher()
  }
  
  func getMockEvents() -> AnyPublisher<[Event], Error> {
    session.dataTaskPublisher(for: Endpoint.mockEvents.request)
      .receive(on: apiQueue)
      .map { $0.data }
      .decode(type: [Event].self, decoder: decoder)
      .mapError { error in
        switch error {
          case is URLError:
            return Error.addressUnreachable(Endpoint.mockEvents.url)
          default:
            return Error.invalidResponse
        }
      }
      .eraseToAnyPublisher()
  }
  
  func getMockLocations() -> AnyPublisher<[Location], Error> {
    session.dataTaskPublisher(for: Endpoint.mockLocations.request)
      .receive(on: apiQueue)
      .map { $0.data }
      .decode(type: [Location].self, decoder: decoder)
      .mapError { error in
        switch error {
          case is URLError:
            return Error.addressUnreachable(Endpoint.mockLocations.url)
          default:
            return Error.invalidResponse
        }
      }
      .eraseToAnyPublisher()
  }
  
  func getMockUsers() -> AnyPublisher<[User], Error> {
    session.dataTaskPublisher(for: Endpoint.mockUsers.request)
      .receive(on: apiQueue)
      .map { $0.data }
      .decode(type: [User].self, decoder: decoder)
      .mapError { error in
        switch error {
          case is URLError:
            return Error.addressUnreachable(Endpoint.mockUsers.url)
          default:
            return Error.invalidResponse
        }
      }
      .eraseToAnyPublisher()
  }
}
