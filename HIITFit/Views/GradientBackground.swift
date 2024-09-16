// GradientBackground

// Created by Raymond Shelton on 9/8/24.

// A view that displays a gradient background, smoothly transitioning between colors from top to bottom.

import SwiftUI

// A view that provides a gradient background for other views
struct GradientBackground: View {
  // Computed property to define the gradient stops
  var gradient: Gradient {
    // Define colors for the gradient
    let color1 = Color("gradient-top")
    let color2 = Color("gradient-bottom")
    let background = Color("background")
    
    // Create a gradient with specific color stops
    return Gradient(
      stops: [
        Gradient.Stop(color: color1, location: 0), // Start color at the top
        Gradient.Stop(color: color2, location: 0.9), // Transition color
        Gradient.Stop(color: background, location: 0.9), // Background color transition
        Gradient.Stop(color: background, location: 1) // End color at the bottom
      ])
  }

  var body: some View {
    // Apply a linear gradient from top to bottom
    LinearGradient(
      gradient: gradient,
      startPoint: .top, // Gradient starts from the top
      endPoint: .bottom) // Gradient ends at the bottom
    .ignoresSafeArea() // Ensures the gradient covers the entire screen, ignoring safe area insets
  }
}

// Preview provider to display the GradientBackground in the SwiftUI canvas
struct GradientBackground_Previews: PreviewProvider {
  static var previews: some View {
    GradientBackground() // Preview the gradient background view
  }
}
