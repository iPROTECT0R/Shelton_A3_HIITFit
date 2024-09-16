// EmbossedButton

// Created by Raymond Shelton on 9/8/24.

// This file defines a custom button style called EmbossedButtonStyle, which allows for different shapes (round or capsule) and provides an embossed appearance with shadow and highlight effects.

import SwiftUI

// Enum to define possible shapes for the embossed button
enum EmbossedButtonShape {
  case round, capsule
}

// Custom ButtonStyle for embossed buttons
struct EmbossedButtonStyle: ButtonStyle {
  var buttonShape = EmbossedButtonShape.capsule // Default shape is capsule
  var buttonScale = 1.0 // Default scale effect when button is pressed

  func makeBody(configuration: Configuration) -> some View {
    let shadow = Color("drop-shadow") // Color for shadow effect
    let highlight = Color("drop-highlight") // Color for highlight effect
    
    return configuration.label
      .padding(10) // Add padding inside the button
      .background(
        GeometryReader { geometry in
          // Create the button shape with custom size
          shape(size: geometry.size)
            .foregroundColor(Color("background")) // Set the background color of the shape
            .shadow(color: shadow, radius: 1, x: 2, y: 2) // Add shadow for depth
            .shadow(color: highlight, radius: 1, x: -2, y: -2) // Add highlight shadow
            .offset(x: -1, y: -1) // Adjust the position of the shape
        })
      .scaleEffect(configuration.isPressed ? buttonScale : 1.0) // Scale the button when pressed
  }

  // ViewBuilder to create different shapes based on the buttonShape property
  @ViewBuilder
  func shape(size: CGSize) -> some View {
    switch buttonShape {
    case .round:
      // Create a round button with stroke
      Circle()
        .stroke(Color("background"), lineWidth: 2) // Stroke color and width
        .frame(
          width: max(size.width, size.height), // Ensure the width and height are equal
          height: max(size.width, size.height))
        .offset(x: -1) // Adjust the position
        .offset(y: -max(size.width, size.height) / 2 +
          min(size.width, size.height) / 2) // Center the circle
    case .capsule:
      // Create a capsule-shaped button with stroke
      Capsule()
        .stroke(Color("background"), lineWidth: 2) // Stroke color and width
    }
  }
}

// Preview provider to display the EmbossedButtonStyle in the SwiftUI canvas
struct EmbossedButton_Previews: PreviewProvider {
  static var previews: some View {
    Button("History") {}
      .fontWeight(.bold) // Apply bold font weight
      .buttonStyle(EmbossedButtonStyle(buttonShape: .round)) // Use embossed button style with round shape
      .padding(40) // Add padding around the button
      .previewLayout(.sizeThatFits) // Adjust the preview size to fit the button
  }
}
