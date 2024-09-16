// HistoryStoreDevData

// Created by Raymond Shelton on 9/8/24.

// Adds functionality to create and manage test data for the HistoryStore, including methods for development data, copying test data, and generating extensive historical data.

import Foundation

// Extends HistoryStore to include methods for creating and copying test data
extension HistoryStore {

  // Creates sample development data for testing
  func createDevData() {
    exerciseDays = [

      // Data for one day, 1 day ago
      ExerciseDay(
        date: Date().addingTimeInterval(-86400), // Date 1 day ago
        exercises: [
          Exercise.exercises[0].exerciseName,  // Exercise 1
          Exercise.exercises[1].exerciseName,  // Exercise 2
          Exercise.exercises[2].exerciseName,  // Exercise 3
          Exercise.exercises[0].exerciseName,  // Exercise 1 (repeated)
          Exercise.exercises[0].exerciseName   // Exercise 1 (repeated)
        ]),

      // Data for one day, 3 days ago
      ExerciseDay(
        date: Date().addingTimeInterval(-86400 * 3), // Date 3 days ago
        exercises: [
          Exercise.exercises[2].exerciseName,  // Exercise 3
          Exercise.exercises[2].exerciseName,  // Exercise 3 (repeated)
          Exercise.exercises[3].exerciseName   // Exercise 4
        ]),

      // Data for one day, 4 days ago
      ExerciseDay(
        date: Date().addingTimeInterval(-86400 * 4), // Date 4 days ago
        exercises: [
          Exercise.exercises[1].exerciseName,  // Exercise 2
          Exercise.exercises[1].exerciseName   // Exercise 2 (repeated)
        ]),

      // Data for one day, 5 days ago
      ExerciseDay(
        date: Date().addingTimeInterval(-86400 * 5), // Date 5 days ago
        exercises: [
          Exercise.exercises[0].exerciseName,  // Exercise 1
          Exercise.exercises[1].exerciseName,  // Exercise 2
          Exercise.exercises[3].exerciseName,  // Exercise 4
          Exercise.exercises[3].exerciseName   // Exercise 4 (repeated)
        ])
    ]
  }

  // Copies a test data file from the app bundle to the documents directory
  func copyHistoryTestData() {
    let filename = "history.plist"  // Name of the file to copy
    if let resourceURL = Bundle.main.resourceURL {
      let sourceURL = resourceURL.appending(component: filename)  // Source URL in the bundle
      let documentsURL = URL.documentsDirectory
      let destinationURL = documentsURL.appending(component: filename)  // Destination URL in the documents directory
      do {
        try FileManager.default.copyItem(at: sourceURL, to: destinationURL)  // Copy the file
      } catch {
        print("Failed to copy", filename)  // Print an error message if the copy fails
      }
      print("Sample History data copied to Documents directory")  // Confirm successful copy
    }
  }

  // Creates a large set of random historical data for testing
  func createHistoryTestData() {
    print("Data construction started")  // Log the start of data creation
    exerciseDays = []  // Clear existing exercise days
    let numberOfDays: Int = 720  // Number of days of test data to generate
    for day in 0..<numberOfDays {
      guard let date = Calendar.current.date(byAdding: .day, value: -day, to: Date()) else {
        continue  // Skip this iteration if date calculation fails
      }
      var exerciseNames: [String] = []  // List to store generated exercise names
      for _ in 0..<Int.random(in: 0...5) {  // Random number of times to add exercises
        for exercise in Exercise.exercises {  // Iterate over all exercises
          if Bool.random() {  // Randomly decide to include this exercise
            exerciseNames.append(exercise.exerciseName)
          }
        }
      }
      if !exerciseNames.isEmpty {
        exerciseDays.append(ExerciseDay(date: date, exercises: exerciseNames))  // Add the generated data to the list
      }
    }
    try? save()  // Save the generated data to the file, ignoring errors
    print("Data construction completed")  // Log the completion of data creation
  }
}
