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
      static let rootURL = "ROOT_URL"
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
  
  static let rootURL: URL = {
    guard let rootURLString = EnvironmentVariables.infoDictionary[Keys.Plist.rootURL] as? String else {
      fatalError("Root URL not set in plist for this environment")
    }
    guard let url = URL(string: rootURLString) else {
      fatalError("Could non construct root url")
    }
    return url
  }()
}
