// HistoryView

// Created by Raymond Shelton on 9/8/24.

// Displays the user's exercise history with options to add, edit, and view details for each day.

import SwiftUI

// A view that displays the user's exercise history
struct HistoryView: View {
  @EnvironmentObject var history: HistoryStore // Access to the history data
  @Binding var showHistory: Bool // Binding to control the visibility of the history view
  @State private var addMode = false // State to toggle between view modes

  // View for the header section of the history view
  var headerView: some View {
    HStack {
      // Button to enter add mode
      Button {
        addMode = true
      } label: {
        Image(systemName: "plus") // Plus icon
      }
      .padding(.trailing) // Add padding to the right
      EditButton() // Edit button for list actions (e.g., delete)
      Spacer() // Pushes content to the sides
      Text("History") // Title text
        .font(.title)
      Spacer() // Pushes content to the sides
      // Button to close the history view
      Button {
        showHistory.toggle()
      } label: {
        Image(systemName: "xmark.circle") // Close icon
      }
      .font(.title) // Set font size
    }
  }

  // Creates a view for a specific day with a disclosure group
  func dayView(day: ExerciseDay) -> some View {
    DisclosureGroup {
      BarChartDayView(day: day) // Display a bar chart for the day's exercises
        .deleteDisabled(true) // Disable deletion of the bar chart
    } label: {
      Text(day.date.formatted(as: "d MMM YYYY")) // Format and display the date
        .font(.headline)
    }
  }

  // Creates a view for each exercise on a specific day
  func exerciseView(day: ExerciseDay) -> some View {
    ForEach(day.uniqueExercises, id: \.self) { exercise in
      Text(exercise) // Display exercise name
        .badge(day.countExercise(exercise: exercise)) // Show count of each exercise
    }
  }

  var body: some View {
    VStack {
      Group {
        if addMode {
          // Display header for add mode
          Text("History")
            .font(.title)
        } else {
          // Display the standard header view
          headerView
        }
      }
      .padding() // Add padding around the header view
      // List of exercise days with edit actions (e.g., delete)
      List($history.exerciseDays, editActions: [.delete]) { $day in
        dayView(day: day) // Display day view for each exercise day
      }
      // Display the AddHistoryView if in add mode
      if addMode {
        AddHistoryView(addMode: $addMode)
          .background(Color.primary.colorInvert() // Invert color for background
            .shadow(color: .primary.opacity(0.5), radius: 7)) // Add shadow effect
      }
    }
    .onDisappear {
      // Save history data when the view disappears
      try? history.save()
    }
  }
}

// Preview provider for displaying the HistoryView in the SwiftUI canvas
struct HistoryView_Previews: PreviewProvider {
  static var history = HistoryStore(preview: true) // Create a preview instance of HistoryStore
  static var previews: some View {
    HistoryView(showHistory: .constant(true)) // Show the HistoryView with the history visible
      .environmentObject(history) // Inject the environment object for history
  }
}
