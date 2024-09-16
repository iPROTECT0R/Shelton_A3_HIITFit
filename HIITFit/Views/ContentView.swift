// ContentView

// Created by Raymond Shelton on 9/8/24.

// The main content view of the app. It uses SceneStorage to remember the selected tab index across app launches. The view includes a gradient background and a TabView that switches between a WelcomeView and various ExerciseViews. The TabView is styled with PageTabViewStyle to hide the index display.

import SwiftUI

struct ContentView: View {
  // Store the currently selected tab index using SceneStorage to maintain state across app launches
  @SceneStorage("selectedTab") private var selectedTab = 9

  var body: some View {
    ZStack {
      // Apply a gradient background to the view
      GradientBackground()
      
      // Create a TabView for switching between different views
      TabView(selection: $selectedTab) {
        // WelcomeView is shown when the selected tab index is 9
        WelcomeView(selectedTab: $selectedTab)
          .tag(9)
        
        // Loop through the list of exercises and create a view for each one
        ForEach(Exercise.exercises.indices, id: \.self) { index in
          ExerciseView(selectedTab: $selectedTab, index: index)
            .tag(index)
        }
      }
      // Set the style of the TabView to PageTabViewStyle with no index display
      .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
  }
}

// Preview provider to show a preview of ContentView in the SwiftUI canvas
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
