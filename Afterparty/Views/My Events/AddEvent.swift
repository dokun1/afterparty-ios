//
//  AddEventView.swift
//  Afterparty
//
//  Created by David Okun on 7/31/22.
//  Copyright © 2022 David Okun. All rights reserved.
//

import SwiftUI
import afterparty_models_swift

struct AddEventView: View {
  @ObservedObject var viewModel = AddEventViewModel()
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  @State private var shouldShowAlert = false
  
  var body: some View {
    NavigationView {
      Form {
        Section {
          TextField("Event Name", text: $viewModel.currentEvent.name)
          DatePicker("Starts at:", selection: $viewModel.currentEvent.start, displayedComponents: [.date, .hourAndMinute])
          DatePicker("Ends at:", selection: $viewModel.currentEvent.end, displayedComponents: [.date, .hourAndMinute])
        }
        Section("Location") {
          NavigationLink {
            PlacesSearchView(viewModel: PlacesSearchViewModel(), eventViewModel: self.viewModel)
          } label: {
            if let place = viewModel.currentEvent.place {
              Label(place.name, systemImage: "mappin.circle")
            } else {
              Label("Choose Location", systemImage: "location.magnifyingglass")
            }
          }
          MapView(event: viewModel.currentEvent).frame(height: 200, alignment: .top)
        }
        Section("Description") {
          if #available(iOS 16.0, *) {
            TextField("What's going down?", text: $viewModel.currentEvent.description, axis: .vertical)
              .padding()
          } else {
            TextField("What's going down?", text: $viewModel.currentEvent.description)
              .padding()
          }
        }
    }
    .navigationBarTitle(viewModel.currentEvent.name.isEmpty ? "Event Name" : viewModel.currentEvent.name, displayMode: .large)
    .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            if viewModel.currentEvent.isSubmissible {
              Task {
                do {
                  try await viewModel.submitEvent()
                  print("we did it: \(String(describing: viewModel.currentEvent.objectId))")
                  self.presentationMode.wrappedValue.dismiss()
                } catch {
                  fatalError(error.localizedDescription)
                }
              }
            }
          } label: {
            Text("Create")
          }
        }
        ToolbarItem(placement: .navigationBarLeading) {
          Button {
            if viewModel.currentEvent.isDirty {
              self.shouldShowAlert = true
            } else {
              self.presentationMode.wrappedValue.dismiss()
            }
          } label: {
            Text("Cancel")
          }
        }
      }
    }.interactiveDismissDisabled(viewModel.currentEvent.isDirty)
      .alert(isPresented: $shouldShowAlert) {
        Alert(title: Text("Are you sure you want to cancel?"),
              message: Text("You will lose all the information you've entered so far."),
              primaryButton: .default(Text("No")),
              secondaryButton: .destructive(Text("Yes")) {
          self.presentationMode.wrappedValue.dismiss()
        })
      }
  }
}

struct AddEventView_Previews: PreviewProvider {
  static var previews: some View {
    AddEventView()
  }
}