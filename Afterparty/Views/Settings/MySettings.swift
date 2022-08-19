//
//  MySettings.swift
//  Afterparty
//
//  Created by David Okun on 5/7/20.
//  Copyright © 2020 David Okun. All rights reserved.
//

import SwiftUI

struct MySettings: View {
  @State var useMocks = false
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var settingsForm: some View {
    Form {
      Section("API Settings") {
        VStack(alignment: .leading) {
          Text("API Root URL").font(.title2)
          Text(EnvironmentVariables.rootURL.absoluteString).font(.callout)
        }
        Toggle("Use Mock API", isOn: $useMocks)
      }
    }
    .navigationTitle("Settings")
    .onAppear {
      useMocks = UserDefaults.standard.bool(forKey: MockAPISession.useMockKey)
    }
    .onChange(of: useMocks) { newValue in
      UserDefaults.standard.set(newValue, forKey: MockAPISession.useMockKey)
      NotificationCenter.default.post(.init(name: .init(MockAPISession.useMockKey)))
    }
  }
  
  var body: some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      NavigationView {
        settingsForm
          .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              self.presentationMode.wrappedValue.dismiss()
            } label: {
              Text("Done").font(.headline)
            }
          }
        }
      }
    } else {
      settingsForm
    }
  }
}

struct MySettings_Previews: PreviewProvider {
  static var previews: some View {
    MySettings()
  }
}
