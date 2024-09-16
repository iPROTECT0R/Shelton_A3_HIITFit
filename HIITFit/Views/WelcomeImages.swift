// WelcomeImages

// Created by Raymond Shelton on 9/8/24.

// An extension to the WelcomeView struct that adds static views for images and welcome text.

import SwiftUI

// Extension to add static views to WelcomeView
extension WelcomeView {
  
  // Static view displaying a collection of images arranged in a ZStack
  static var images: some View {
    ZStack {
      // Image of hands with a specific size and circular clipping
      Image("hands")
        .resizedToFill(width: 100, height: 100)
        .clipShape(Circle())
        .offset(x: -88, y: 30)
      
      // Image of exercise with a smaller size and circular clipping
      Image("exercise")
        .resizedToFill(width: 40, height: 40)
        .clipShape(Circle())
        .offset(x: -54, y: -80)
      
      // Image of head with a very small size and circular clipping
      Image("head")
        .resizedToFill(width: 20, height: 20)
        .clipShape(Circle())
        .offset(x: -44, y: -40)
      
      // Image of arm with a medium size and circular clipping
      Image("arm")
        .resizedToFill(width: 60, height: 60)
        .clipShape(Circle())
        .offset(x: -133, y: -60)
      
      // Image of step-up with a large size and circular clipping
      Image("step-up")
        .resizedToFill(width: 180, height: 180)
        .clipShape(Circle())
        .offset(x: 74)
    }
    .frame(maxWidth: .infinity, maxHeight: 220) // Constrain the maximum width and height
    .shadow(color: Color("drop-shadow"), radius: 6, x: 5, y: 5) // Apply shadow for depth
    .padding(.top, 10)
    .padding(.leading, 20)
    .padding(.bottom, 10)
  }

  // Static view displaying the welcome text
  static var welcomeText: some View {
    return HStack(alignment: .bottom) {
      VStack(alignment: .leading) {
        // Main title text
        Text("Get fit")
          .font(.largeTitle)
          .fontWeight(.black)
          .kerning(2)
        
        // Subtitle text
        Text("by exercising at home")
          .font(.headline)
          .fontWeight(.medium)
          .kerning(2)
          .fixedSize(horizontal: false, vertical: true)
      }
    }
  }
}

// Preview provider for displaying previews of WelcomeView's static views
struct WelcomeImages_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      WelcomeView.images
      WelcomeView.welcomeText
    }
  }
}
