// BarChartDayView

// Created by Raymond Shelton on 9/8/24.

// Displays a bar chart visualizing the count of each exercise for a specific day.

import Charts
import SwiftUI

// View to display a bar chart for a specific day of exercise history
struct BarChartDayView: View {
  let day: ExerciseDay // The exercise day data to be displayed in the chart

  var body: some View {
    Chart {
      // Create a bar for each exercise
      ForEach(Exercise.names, id: \.self) { name in
        BarMark(
          x: .value(name, name), // X-axis: Exercise name
          y: .value("Total Count", day.countExercise(exercise: name))) // Y-axis: Total count of the exercise
        .foregroundStyle(Color("history-bar")) // Color of the bar
      }
      // Add a rule mark at y = 1 to indicate the minimum threshold
      RuleMark(y: .value("Exercise", 1))
        .foregroundStyle(.red) // Color of the rule mark
    }
    .padding() // Add padding around the chart
  }
}

// Preview provider to display the BarChartDayView in the SwiftUI canvas
struct BarChartDayView_Previews: PreviewProvider {
  static var history = HistoryStore(preview: true) // Create a preview instance of HistoryStore
  static var previews: some View {
    BarChartDayView(day: history.exerciseDays[0]) // Show a bar chart for the first day of exercise history
      .environmentObject(history) // Inject the preview instance of HistoryStore
  }
}
