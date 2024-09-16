// VideoPlayerView

// Created by Raymond Shelton on 9/8/24.

// This view displays a video player for a specified video file. It checks if the video file exists in the main bundle and plays it using AVPlayer. If the video file is not found, it shows an error message in red.

import SwiftUI
import AVKit

// A view that displays a video player for a given video file
struct VideoPlayerView: View {
  let videoName: String // Name of the video file (without the extension)

  var body: some View {
    // Check if the video file exists in the main bundle
    if let url = Bundle.main.url(
      forResource: videoName, // The name of the video file
      withExtension: "mp4" // The file extension
    ) {
      // Create and display a VideoPlayer using AVPlayer with the video URL
      VideoPlayer(player: AVPlayer(url: url))
    } else {
      // Display an error message if the video file is not found
      Text("Couldn’t find \(videoName).mp4")
        .foregroundColor(.red) // Show error message in red color
    }
  }
}

// Preview provider to show a preview of VideoPlayerView in the SwiftUI canvas
struct VideoPlayerView_Previews: PreviewProvider {
  static var previews: some View {
    VideoPlayerView(videoName: "squat") // Preview with a sample video name
  }
}
