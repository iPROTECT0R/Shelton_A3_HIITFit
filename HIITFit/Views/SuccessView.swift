// SuccessView

// Created by Raymond Shelton on 9/8/24.

// This view displays a success message after completing all exercises. It shows a congratulatory message and an icon, with a button to continue that updates the selected tab index and dismisses the view.

import SwiftUI

// A view that displays a success message after completing exercises
struct SuccessView: View {
  // Provides a way to dismiss the view
  @Environment(\.dismiss) var dismiss
  
  // Binding to the selected tab index in the parent view
  @Binding var selectedTab: Int

  var body: some View {
    ZStack {
      // Main content of the success view
      VStack {
        // Display a "High Five!" icon
        Image(systemName: "hand.raised.fill")
          .resizedToFill(width: 75, height: 75) // Set the size of the icon
          .foregroundColor(.purple) // Set the color of the icon
        
        // Display a congratulatory message
        Text("High Five!")
          .font(.largeTitle) // Large font for the title
          .fontWeight(.bold) // Bold font weight
        
        // Display additional text with instructions
        Text("""
          Good job completing all four exercises!
          Remember tomorrow's another day.
          So eat well and get some rest.
          """)
          .foregroundColor(.gray) // Gray color for the text
          .multilineTextAlignment(.center) // Center-align the text
      }
      
      // Button to continue, placed at the bottom of the view
      VStack {
        Spacer()
        Button("Continue") {
          // Set the selected tab to 9 and dismiss the view
          selectedTab = 9
          dismiss()
        }
        .padding() // Add padding around the button
      }
    }
  }
}

// Preview provider to show a preview of SuccessView in the SwiftUI canvas
struct SuccessView_Previews: PreviewProvider {
  static var previews: some View {
    SuccessView(selectedTab: .constant(3))
  }
}
