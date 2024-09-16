// ImageExtension

// Created by Raymond Shelton on 9/8/24.

// Adds a method to resize an image to fit a specified width and height while keeping its aspect ratio.

import SwiftUI

// Extends the Image view with additional functionality
extension Image {

  // Resizes the image to fill a specified width and height while maintaining its aspect ratio
  func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
    self
      .resizable()  // Makes the image resizable
      .aspectRatio(contentMode: .fill)  // Ensures the image fills the specified frame while maintaining its aspect ratio
      .frame(width: width, height: height)  // Sets the frame to the specified width and height
  }
}
