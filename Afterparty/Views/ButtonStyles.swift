//
//  ButtonStyles.swift
//  Afterparty
//
//  Created by David Okun on 8/13/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration.label
      .padding(5)
      .background(
        RoundedRectangle(cornerRadius: 10, style: .continuous)
          .fill(Color.blue)
      )
      .scaleEffect(configuration.isPressed ? 0.8: 1)
      .foregroundColor(.white)
      .animation(.spring(), value: 1)
  }
}

struct SecondaryButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(2)
      .scaleEffect(configuration.isPressed ? 0.8 : 1)
      .foregroundColor(.blue)
      .animation(.spring(), value: 1)
      .cornerRadius(5)
      .border(.blue)
  }
}

/// A button with some cool effects!
public struct AfterpartyButton: View {
  /// This is the title for the button.
  public var title: String
  /// This is the name to use for the image next to the text string
  public var imageName: String?
  /// This is the closure for what the button does.
  public var action: () -> Void
  /// This is the body for the button - don't override this.
  
  public init(title: String, imageName: String? = nil, action: @escaping () -> Void) {
    self.title = title
    self.imageName = imageName
    self.action = action
  }
  
  public var body: some View {
    Button(action: action) {
      Label(title, systemImage: imageName ?? "").padding()
    }
  }
}

struct AfterpartyButton_Previews: PreviewProvider {
  static var previews: some View {
    AfterpartyButton(title: "Primary Button, no image") {
      print("you tapped me!")
    }.buttonStyle(PrimaryButtonStyle())
    AfterpartyButton(title: "Primary Button", imageName: "tray.and.arrow.down.fill") {
      print("you tapped me!")
    }.buttonStyle(PrimaryButtonStyle())
    AfterpartyButton(title: "Secondary Button", imageName: "tray.and.arrow.down.fill") {
      print("you tapped me!")
    }.buttonStyle(SecondaryButtonStyle())
  }
}
