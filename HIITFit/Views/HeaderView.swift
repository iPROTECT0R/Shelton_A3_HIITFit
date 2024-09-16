// HeaderView

// Created by Raymond Shelton on 9/8/24.

// This view shows a header with a large title and a row of dots representing each exercise. The selected tab is highlighted with a larger, semi-transparent dot, and tapping on a dot changes the selected tab.

import SwiftUI

// A view that displays a header with a title and navigation dots for exercises
struct HeaderView: View {
  @Binding var selectedTab: Int // Binding to the currently selected tab
  let titleText: String // Title text to display in the header

  var body: some View {
    VStack {
      // Display the title text in a large, bold font
      Text(titleText)
        .font(.largeTitle)
        .fontWeight(.black)
        .foregroundColor(.white) // White color for the title text
      
      HStack {
        // Create a row of dots for each exercise
        ForEach(Exercise.exercises.indices, id: \.self) { index in
          ZStack {
            // Larger dot to indicate the selected tab
            Circle()
              .frame(width: 32, height: 32) // Size of the dot
              .foregroundColor(.white) // White color for the dot
              .opacity(index == selectedTab ? 0.5 : 0.0) // Highlight the selected tab
            
            // Smaller dot in the center
            Circle()
              .frame(width: 16, height: 16) // Size of the smaller dot
              .foregroundColor(.white) // White color for the dot
          }
          .onTapGesture {
            // Update the selected tab when the dot is tapped
            selectedTab = index
          }
        }
      }
      .font(.title2) // Font size for the dots
    }
  }
}

// Preview provider to show a preview of HeaderView in the SwiftUI canvas
struct HeaderView_Previews: PreviewProvider {
  static var previews: some View {
    // Preview HeaderView with a sample selectedTab and titleText
    HeaderView(selectedTab: .constant(0), titleText: "Squat")
      .previewLayout(.sizeThatFits) // Adjust preview size
  }
}
