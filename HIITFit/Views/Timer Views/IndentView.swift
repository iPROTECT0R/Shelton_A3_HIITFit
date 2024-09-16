// IndentView

// Created by Raymond Shelton on 9/8/24.

// A custom view that adds a circular background with shadows to its content, creating an indented effect.

import SwiftUI

// A custom view that provides a circular background with shadows around its content
struct IndentView<Content: View>: View {
  // The content to be displayed inside the IndentView
  var content: Content

  // Custom initializer to accept a content view
  init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    ZStack {
      // Display the content with a circular background and shadow effects
      content
        .background(
          GeometryReader { geometry in
            // Create a circular background with shadows
            Circle()
              .inset(by: -4) // Extend the circle to cover the content
              .stroke(Color("background"), lineWidth: 8) // Stroke around the circle
              .shadow(color: Color("drop-shadow").opacity(0.5), radius: 6, x: 6, y: 6) // Shadow for depth
              .shadow(color: Color("drop-highlight"), radius: 6, x: -6, y: -6) // Highlight shadow for contrast
              .foregroundColor(Color("background")) // Set the circle color
              .clipShape(Circle().inset(by: -1)) // Clip the shape for the inset effect
              .resized(size: geometry.size) // Adjust the size of the circle
          }
        )
    }
  }
}

// Extension to resize a view based on given size
private extension View {
  func resized(size: CGSize) -> some View {
    self
      .frame(
        width: max(size.width, size.height),
        height: max(size.width, size.height))
      .offset(y: -max(size.width, size.height) / 2
        + min(size.width, size.height) / 2)
  }
}

// Preview provider to show a preview of IndentView in the SwiftUI canvas
struct IndentView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      // Preview of IndentView with a large text
      IndentView {
        Text("5")
          .font(.system(size: 90, design: .rounded))
          .frame(width: 120, height: 120)
      }
      .padding(.bottom, 50)
      
      // Preview of IndentView with an image
      IndentView {
        Image(systemName: "hare.fill")
          .font(.largeTitle)
          .foregroundColor(.purple)
          .padding(20)
      }
    }
  }
}
