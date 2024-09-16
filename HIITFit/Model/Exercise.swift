// Exercise

// Created by Raymond Shelton on 9/8/24.

// Represents different exercises and provides a list of exercises with their names and associated video files.

import Foundation

// Defines a struct to represent an exercise
struct Exercise {
  let exerciseName: String  // The name of the exercise
  let videoName: String     // The name of the video file associated with the exercise

  // Enum to list all possible exercise types
  enum ExerciseEnum: String {
    case squat = "Squat"          // Squat exercise
    case stepUp = "Step Up"      // Step Up exercise
    case burpee = "Burpee"        // Burpee exercise
    case sunSalute = "Sun Salute" // Sun Salute exercise
  }
}

extension Exercise {
  
  // A static list of all exercises with their names and video file names
  static let exercises = [
    Exercise(
      exerciseName: ExerciseEnum.squat.rawValue,  // Use enum value for exercise name
      videoName: "squat"),                        // Video file name for squat exercise
    Exercise(
      exerciseName: ExerciseEnum.stepUp.rawValue,  // Use enum value for exercise name
      videoName: "step-up"),                      // Video file name for step-up exercise
    Exercise(
      exerciseName: ExerciseEnum.burpee.rawValue,  // Use enum value for exercise name
      videoName: "burpee"),                       // Video file name for burpee exercise
    Exercise(
      exerciseName: ExerciseEnum.sunSalute.rawValue, // Use enum value for exercise name
      videoName: "sun-salute")                     // Video file name for sun salute exercise
  ]
  
  // A static list of all exercise names
  static let names: [String] = [
    ExerciseEnum.squat.rawValue,    // Name for squat exercise
    ExerciseEnum.stepUp.rawValue,   // Name for step-up exercise
    ExerciseEnum.burpee.rawValue,    // Name for burpee exercise
    ExerciseEnum.sunSalute.rawValue  // Name for sun salute exercise
  ]
}
