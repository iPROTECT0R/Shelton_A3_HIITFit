// BarChartWeekView

// Created by Raymond Shelton on 9/8/24.

// A view that displays a bar or line chart representing exercise history for the past week. Users can toggle between chart types.

import SwiftUI
import Charts

// A view that displays exercise history for the last week using a bar or line chart
struct BarChartWeekView: View {
  @EnvironmentObject var history: HistoryStore // Environment object that provides exercise history data
  @State private var weekData: [ExerciseDay] = [] // State variable to store data for the chart
  @State private var isBarChart = true // State variable to toggle between bar chart and line chart

  var body: some View {
    VStack {
      Text("History for Last Week")
        .font(.title)
        .padding()
      
      // Display either a bar chart or a line chart based on the isBarChart state
      if isBarChart {
        Chart(weekData) { day in
          ForEach(Exercise.names, id: \.self) { name in
            BarMark(
              x: .value("Date", day.date, unit: .day),
              y: .value("Total Count", day.countExercise(exercise: name)))
            .foregroundStyle(by: .value("Exercise", name))
          }
        }
        .chartForegroundStyleScale([
          "Burpee": Color("chart-burpee"),
          "Squat": Color("chart-squat"),
          "Step Up": Color("chart-step-up"),
          "Sun Salute": Color("chart-sun-salute")
        ])
        .padding()
      } else {
        Chart(weekData) { day in
          LineMark(
            x: .value("Date", day.date, unit: .day),
            y: .value("Total Count", day.exercises.count))
          .symbol(.circle)
          .interpolationMethod(.catmullRom)
        }
        .padding()
      }

      // Toggle to switch between bar chart and line chart
      Toggle("Bar Chart", isOn: $isBarChart)
        .padding()
    }
    .onAppear {
      // Load and prepare week data when the view appears
      let firstDate = history.exerciseDays.first?.date ?? Date()
      let dates = firstDate.previousSevenDays
      weekData = dates.map { date in
        history.exerciseDays.first(
          where: { $0.date.isSameDay(as: date) })
        ?? ExerciseDay(date: date)
      }
    }
  }
}

// Preview provider for displaying previews of BarChartWeekView in the SwiftUI canvas
struct BarChartWeekView_Previews: PreviewProvider {
  static var previews: some View {
    BarChartWeekView()
      .environmentObject(HistoryStore(preview: true))
  }
}
