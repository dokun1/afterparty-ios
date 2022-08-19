//
//  ProfileView.swift
//  Afterparty
//
//  Created by David Okun on 8/13/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
  @State private var username: String = UserDefaults.standard.object(forKey: MockAPISession.mockUsernameKey) as? String ?? ""
  @State private var emailAddress: String = UserDefaults.standard.object(forKey: MockAPISession.mockEmailKey) as? String ?? ""
  @State private var authToken: String = UserDefaults.standard.object(forKey: MockAPISession.mockAuthTokenKey) as? String ?? ""
  @State private var isSignedIn: Bool = !(UserDefaults.standard.object(forKey: MockAPISession.mockAuthTokenKey) as? String ?? "").isEmpty
  @State private var errorAlertMessage = ""
  @State private var shouldShowAlert = false
  
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  private func changeStatus(from currentStatus: Bool) {
    if !isSignedIn {
      if username.isEmpty {
        errorAlertMessage = "You need to enter a username"
        return shouldShowAlert.toggle()
      }
      if emailAddress.isEmpty {
        errorAlertMessage = "You need to enter an email address"
        return shouldShowAlert.toggle()
      }
      authToken = MockAPISession.randomString(length: 20)
      UserDefaults.standard.setValue(username, forKey: MockAPISession.mockUsernameKey)
      UserDefaults.standard.setValue(emailAddress, forKey: MockAPISession.mockEmailKey)
      UserDefaults.standard.setValue(authToken, forKey: MockAPISession.mockAuthTokenKey)
      isSignedIn.toggle()
    } else {
      authToken = ""
      UserDefaults.standard.setValue(authToken, forKey: MockAPISession.mockAuthTokenKey)
      isSignedIn.toggle()
    }
  }
  
  var userForm: some View {
    Form {
      Section("Read me first!") {
        Text("As of right now, there is no sign in function for this app. Use this to \"mock\" the act of signing in.")
        Text("Below, you'll enter your username and email address, and tap \"sign in\". You can sign out if you want to change to a different user. Actual sign in functionality will come at a later date.")
      }
      Section("User Details") {
        TextField("User name", text: $username)
          .disabled(isSignedIn)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .foregroundColor(isSignedIn ? .gray : .black)
        TextField("Email address", text: $emailAddress)
          .keyboardType(.emailAddress)
          .disabled(isSignedIn)
          .textInputAutocapitalization(.never)
          .autocorrectionDisabled(true)
          .foregroundColor(isSignedIn ? .gray : .black)
        TextField("Mock auth token will show up here", text: $authToken)
          .disabled(true)
          .foregroundColor(isSignedIn ? .gray : .black)
      }
      Section {
        Button {
          changeStatus(from: isSignedIn)
        } label: {
          if isSignedIn {
            Label("Sign Out", systemImage: "person.badge.minus.fill")
          } else {
            Label("Sign In", systemImage: "person.badge.plus.fill")
          }
        }
      }
    }.alert(errorAlertMessage, isPresented: $shouldShowAlert) {
      Button {} label: {
        Text("OK")
      }
    }.navigationTitle("User Profile")

  }
  
  var body: some View {
    if UIDevice.current.userInterfaceIdiom == .phone {
      NavigationView {
        userForm
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
      userForm
    }
  }
}

struct ProfileView_Previews: PreviewProvider {
  static var previews: some View {
    ProfileView()
  }
}
