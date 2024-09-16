// HIITFitApp

// Created by Raymond Shelton on 9/8/24.

// The main entry point for the HIITFit application. Sets up the app environment and handles initialization tasks.

import SwiftUI

@main
struct HIITFitApp: App {
  @StateObject private var historyStore = HistoryStore() // State object that manages history data

  var body: some Scene {
    WindowGroup {
      ContentView() // Main view of the application
        .environmentObject(historyStore) // Injects historyStore as an environment object
        .onAppear {
          // Print the documents directory URL for debugging purposes
          print(URL.documentsDirectory)
        }
        .alert(isPresented: $historyStore.loadingError) {
          // Display an alert if there is an error loading history data
          Alert(
            title: Text("History"),
            message: Text(
              """
              Unfortunately we can’t load your past history.
              Email support:
                support@xyz.com
              """)
          )
        }
    }
  }
}
