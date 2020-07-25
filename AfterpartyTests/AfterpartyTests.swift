//
//  AfterpartyTests.swift
//  AfterpartyTests
//
//  Created by David Okun on 5/2/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import XCTest
@testable import afterparty_models_swift
@testable import Afterparty

class AfterpartyTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testMockEventsNotNil() throws {
    let mockEvents = MockData.sampleEvents
    XCTAssertNotNil(mockEvents, "sample events should not be nil")
  }
  
  func testMockEventsMoreThanOne() throws {
    let mockEvents = MockData.sampleEvents
    XCTAssertGreaterThan(mockEvents.count, 1, "there should be more than one mock event")
  }
  
  func testMockUsersNotNil() throws {
    let mockUsers = MockData.participants
    XCTAssertNotNil(mockUsers, "sample users should not be nil")
  }
  
  func testMockUsersMoreThanOne() throws {
    let mockUsers = MockData.participants
    XCTAssertGreaterThan(mockUsers.count, 1, "there should be more than one mock user")
  }
  
  func testMockLocationsNotNil() throws {
    let mockLocations = MockData.southLocations
    XCTAssertNotNil(mockLocations, "sample locations should not be nil")
  }
  
  func testMockLocationsMoreThanOne() throws {
    let mockLocations = MockData.southLocations
    XCTAssertGreaterThan(mockLocations.count, 1, "there should be more than one mock location")
  }
  
}
