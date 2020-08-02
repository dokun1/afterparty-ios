//
//  EnvironmentVariables.swift
//  Afterparty
//
//  Created by David Okun on 7/4/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import Foundation

public enum EnvironmentVariables {
  enum Keys {
    enum Plist {
      static let appCenterSecret = "MS_APP_CENTER_SECRET"
      static let rootURLHost = "ROOT_URL_HOST"
      static let rootURLScheme = "ROOT_URL_SCHEME"
      static let rootURLPort = "ROOT_URL_PORT"
    }
  }
  
  private static let infoDictionary: [String: Any] = {
    guard let dict = Bundle.main.infoDictionary else {
      fatalError("Plist file not found")
    }
    return dict
  }()
  
  static let appCenterSecret: String = {
    guard let appCenterSecretString = EnvironmentVariables.infoDictionary[Keys.Plist.appCenterSecret] as? String else {
      fatalError("App Center Secret not set in plist for this environment")
    }
    return appCenterSecretString
  }()
  
  static let rootURLHost: String = {
    guard let rootURLHost = EnvironmentVariables.infoDictionary[Keys.Plist.rootURLHost] as? String else {
      fatalError("Root URL host not set in plist for this environment")
    }
    return rootURLHost
  }()
  
  static let rootURLScheme: String = {
    guard let rootURLScheme = EnvironmentVariables.infoDictionary[Keys.Plist.rootURLScheme] as? String else {
      fatalError("Root URL scheme not set in plist for this environment")
    }
    return rootURLScheme
  }()
  
  static let rootURLPort: Int = {
    if rootURLHost == "localhost" {
      return 8080
    } else {
      return 80
    }
  }()
  
  static let rootURL: URL = {
    var components = URLComponents()
    components.scheme = rootURLScheme
    components.host = rootURLHost
    if rootURLPort != 80 {
      components.port = rootURLPort
    }
    guard let url = components.url else {
      fatalError("Could not construct root url")
    }
    return url
  }()
}
