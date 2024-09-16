// HistoryStore

// Created by Raymond Shelton on 9/8/24.

// Represents different exercises and provides a list of exercises with their names and associated video files.

import Foundation

// Represents a single day of exercises
struct ExerciseDay: Identifiable {

  let id = UUID()  // Unique identifier for each ExerciseDay

  var date: Date  // The date for this set of exercises

  var exercises: [String] = []  // List of exercise names done on this day

  // Computed property to get unique exercises for the day, sorted alphabetically
  var uniqueExercises: [String] {
    Array(Set(exercises)).sorted(by: <)
  }

  // Counts how many times a specific exercise was done on this day
  func countExercise(exercise: String) -> Int {
    exercises.filter { $0 == exercise }.count
  }
}

// Manages the history of exercises, loading and saving data
class HistoryStore: ObservableObject {

  @Published var exerciseDays: [ExerciseDay] = []  // List of all ExerciseDays

  @Published var loadingError = false  // Flag to indicate if there was an error loading data

  // Enum to handle file-related errors
  enum FileError: Error {
    case loadFailure  // Error when loading data
    case saveFailure  // Error when saving data
  }

  // Initialize the HistoryStore, with optional preview data for testing
  init(preview: Bool = false) {
    do {
      try load()  // Try to load existing data
    } catch {
      loadingError = true  // Set error flag if loading fails
    }
    
    #if DEBUG
    if preview {
      createDevData()  // Create dummy data for development
    } else {
      if exerciseDays.isEmpty {
        copyHistoryTestData()  // Copy test data if no data is present
        try? load()  // Try to load the data again
      }
    }
    #endif
  }

  // URL for saving and loading the data file
  var dataURL: URL {
    URL.documentsDirectory
      .appendingPathComponent("history.plist")  // File name for saving history data
  }

  // Load the exercise history from the file
  func load() throws {
    guard let data = try? Data(contentsOf: dataURL) else {
      return  // No data to load, exit early
    }
    do {
      // Deserialize the plist data into an array of ExerciseDay
      let plistData = try PropertyListSerialization.propertyList(
        from: data,
        options: [],
        format: nil)
      let convertedPlistData = plistData as? [[Any]] ?? []
      exerciseDays = convertedPlistData.map {
        ExerciseDay(
          date: $0[1] as? Date ?? Date(),
          exercises: $0[2] as? [String] ?? [])
      }
    } catch {
      throw FileError.loadFailure  // Throw an error if deserialization fails
    }
  }

  // Save the current exercise history to the file
  func save() throws {
    // Convert ExerciseDay objects to a plist-compatible format
    let plistData = exerciseDays.map {
      [$0.id.uuidString, $0.date, $0.exercises]
    }
    do {
      // Serialize the data and write it to the file
      let data = try PropertyListSerialization.data(
        fromPropertyList: plistData,
        format: .binary,
        options: .zero)
      try data.write(to: dataURL, options: .atomic)
    } catch {
      throw FileError.saveFailure  // Throw an error if saving fails
    }
  }

  // Add an exercise to the current day, or create a new entry if needed
  func addDoneExercise(_ exerciseName: String) {
    let today = Date()  // Get the current date
    if let firstDate = exerciseDays.first?.date,
      today.isSameDay(as: firstDate) {
      // If today is the same as the first recorded date, add the exercise to that entry
      exerciseDays[0].exercises.append(exerciseName)
    } else {
      // Otherwise, create a new ExerciseDay for today and insert it at the start
      exerciseDays.insert(
        ExerciseDay(date: today, exercises: [exerciseName]),
        at: 0)
    }
    do {
      try save()  // Save changes to the file
    } catch {
      fatalError(error.localizedDescription)  // Crash if saving fails
    }
  }

  // Add an exercise on a specific date
  func addExercise(date: Date, exerciseName: String) {
    let exerciseDay = ExerciseDay(date: date, exercises: [exerciseName])
    if let index = exerciseDays.firstIndex(
      where: { $0.date.yearMonthDay <= date.yearMonthDay }) {
      if date.isSameDay(as: exerciseDays[index].date) {
        // If the date matches an existing ExerciseDay, add the exercise to that entry
        exerciseDays[index].exercises.append(exerciseName)
      } else {
        // Otherwise, insert the new ExerciseDay in the correct position
        exerciseDays.insert(exerciseDay, at: index)
      }
    } else {
      // If no matching date is found, just add the new ExerciseDay to the end
      exerciseDays.append(exerciseDay)
    }
    try? save()  // Save changes to the file, ignore errors
  }
}
