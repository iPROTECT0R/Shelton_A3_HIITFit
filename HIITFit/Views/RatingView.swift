// RatingView

// Created by Raymond Shelton on 9/8/24.

// This view lets users rate an exercise with up to 5 waveforms. It uses AppStorage to save the ratings across app launches and updates the display when the user interacts with the rating buttons. The color of the stars changes based on the current rating.

import SwiftUI

// A view that allows users to rate an exercise with waveforms
struct RatingView: View {
  let exerciseIndex: Int // Index of the exercise being rated
  
  // AppStorage to persist ratings across app launches
  @AppStorage("ratings") private var ratings = ""
  
  @State private var rating = 0 // Current rating for the exercise
  let maximumRating = 5 // Maximum rating value (e.g., 5 stars)

  let onColor = Color("ratings") // Color for selected rating
  let offColor = Color.gray // Color for unselected rating

  // Initialize and pad the ratings string to ensure it matches the number of exercises
  init(exerciseIndex: Int) {
    self.exerciseIndex = exerciseIndex
    let desiredLength = Exercise.exercises.count
    if ratings.count < desiredLength {
      ratings = ratings.padding(
        toLength: desiredLength,
        withPad: "0", // Pad with zeros if ratings string is shorter
        startingAt: 0
      )
    }
  }

  // Convert the ratings string to an integer rating value
  // swiftlint:disable:next strict_fileprivate
  fileprivate func convertRating() {
    let index = ratings.index(
      ratings.startIndex,
      offsetBy: exerciseIndex
    )
    let character = ratings[index]
    rating = character.wholeNumberValue ?? 0
  }

  var body: some View {
    HStack {
      // Create rating buttons (stars) for the maximum rating value
      ForEach(1 ..< maximumRating + 1, id: \.self) { index in
        Button(action: {
          updateRating(index: index)
        }, label: {
          Image(systemName: "waveform.path.ecg") // Use a system icon as the star
            .foregroundColor(
              index > rating ? offColor : onColor // Set color based on rating
            )
            .font(.body)
        })
        .buttonStyle(EmbossedButtonStyle(buttonShape: .round)) // Apply custom button style
        .onChange(of: ratings) { _ in
          convertRating() // Update rating when the ratings string changes
        }
        .onAppear {
          convertRating() // Initialize rating when the view appears
        }
      }
    }
    .font(.largeTitle) // Set font size for the rating stars
  }

  // Update the rating value and save it to AppStorage
  func updateRating(index: Int) {
    rating = index
    let index = ratings.index(
      ratings.startIndex,
      offsetBy: exerciseIndex
    )
    ratings.replaceSubrange(index...index, with: String(rating)) // Update ratings string
  }
}

// Preview provider to show a preview of RatingView in the SwiftUI canvas
struct RatingView_Previews: PreviewProvider {
  @AppStorage("ratings") static var ratings: String?
  
  static var previews: some View {
    ratings = nil // Reset ratings for preview
    return RatingView(exerciseIndex: 0)
      .previewLayout(.sizeThatFits) // Adjust preview size
  }
}
