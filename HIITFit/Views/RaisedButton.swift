// RaisedButton

// Created by Raymond Shelton on 9/8/24.

// This file defines a custom button style called RaisedButton and its associated style for a raised appearance in SwiftUI. The RaisedButton has a distinct style with padding, shadows, and custom text formatting.

import SwiftUI

// A custom button view with a raised style
struct RaisedButton: View {
  let buttonText: String // Text to display on the button
  let action: () -> Void // Action to perform when the button is tapped

  var body: some View {
    Button(action: {
      action() // Execute the provided action when the button is tapped
    }, label: {
      Text(buttonText) // Display the button text
        .raisedButtonTextStyle() // Apply custom text style
    })
    .buttonStyle(.raised) // Apply the raised button style
  }
}

// Extension to define a custom button style as a static property
extension ButtonStyle where Self == RaisedButtonStyle {
  static var raised: RaisedButtonStyle {
    .init() // Return an instance of RaisedButtonStyle
  }
}

// Custom button style for a raised appearance
struct RaisedButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .frame(maxWidth: .infinity) // Make the button take up the full width
      .padding([.top, .bottom], 12) // Add padding to the top and bottom
      .background(
        Capsule()
          .foregroundColor(Color("background")) // Set background color
          .shadow(color: Color("drop-shadow"), radius: 4, x: 6, y: 6) // Add shadow for depth
          .shadow(color: Color("drop-highlight"), radius: 4, x: -6, y: -6) // Add highlight shadow
      )
  }
}

// Extension to apply a custom text style for raised buttons
extension Text {
  func raisedButtonTextStyle() -> some View {
    self
      .font(.body) // Set the font to body
      .fontWeight(.bold) // Set the font weight to bold
  }
}

// Preview provider to display the RaisedButton in the SwiftUI canvas
struct RaisedButton_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      RaisedButton(buttonText: "Get Started") {
        print("Hello World") // Print a message when button is tapped
      }
      .buttonStyle(.raised) // Apply the raised button style
      .padding(20) // Add padding around the button
    }
    .background(Color("background")) // Set background color for the preview
    .previewLayout(.sizeThatFits) // Adjust the preview size to fit the button
  }
}
