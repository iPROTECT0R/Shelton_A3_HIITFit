// ContainerView

// Created by Raymond Shelton on 9/8/24.

// This file defines a generic container view called ContainerView, which provides a rounded rectangle background and allows for custom content to be placed inside it.

import SwiftUI

// A generic container view that wraps around other content views
struct ContainerView<Content: View>: View {
  var content: Content // The content view to be displayed inside the container

  // Initialize the container with a content view builder
  init(@ViewBuilder content: () -> Content) {
    self.content = content() // Capture the content view provided by the builder
  }

  var body: some View {
    ZStack {
      // Background rounded rectangle with a specified corner radius
      RoundedRectangle(cornerRadius: 25.0)
        .foregroundColor(Color("background")) // Set the background color of the rectangle

      VStack {
        Spacer() // Push content up to the top
        // A horizontal rectangle for additional spacing or design element
        Rectangle()
          .frame(height: 25) // Set the height of the rectangle
          .foregroundColor(Color("background")) // Match the background color
      }
      content // Place the provided content view on top of the background
    }
  }
}

// Preview provider to display the ContainerView in the SwiftUI canvas
struct Container_Previews: PreviewProvider {
  static var previews: some View {
    ContainerView {
      VStack {
        RaisedButton(buttonText: "Hello World") {} // Sample raised button
          .padding(50) // Add padding around the button
        Button("Tap me!") {} // Sample button with embossed style
          .buttonStyle(EmbossedButtonStyle(buttonShape: .round)) // Apply custom button style
      }
    }
    .padding(50) // Add padding around the container view
    .previewLayout(.sizeThatFits) // Adjust the preview size to fit the container’s content
  }
}
