// AddHistoryView

// Created by Raymond Shelton on 9/8/24.

// Provides a view for adding new exercise entries, including date selection and exercise buttons.

import SwiftUI

// View for adding new exercise history entries
struct AddHistoryView: View {
  @Binding var addMode: Bool // Binding to control whether add mode is active
  @State private var exerciseDate = Date() // State to store the selected date for the exercise

  var body: some View {
    VStack {
      ZStack {
        // Title and Done button for the view
        Text("Add Exercise")
          .font(.title)
        Button("Done") {
          addMode = false // Exit add mode when Done is pressed
        }
        .frame(maxWidth: .infinity, alignment: .trailing) // Align the button to the right
      }
      ButtonsView(date: $exerciseDate) // Display buttons for selecting exercises
      DatePicker(
        "Choose Date",
        selection: $exerciseDate,
        in: ...Date(), // Limit the date picker to select dates up to today
        displayedComponents: .date) // Show only the date component
      .datePickerStyle(.graphical) // Use a graphical style for the date picker
    }
    .padding() // Add padding around the content
  }
}

// View for displaying exercise selection buttons
struct ButtonsView: View {
  @EnvironmentObject var history: HistoryStore // Access to the HistoryStore for adding exercises
  @Binding var date: Date // Binding to the selected date

  var body: some View {
    HStack {
      ForEach(Exercise.exercises.indices, id: \.self) { index in
        let exerciseName = Exercise.exercises[index].exerciseName // Get the exercise name
        // Button for each exercise
        Button(exerciseName) {
          history.addExercise(date: date, exerciseName: exerciseName) // Add exercise to history
        }
      }
    }
    .buttonStyle(EmbossedButtonStyle(buttonScale: 1.5)) // Apply custom button style
  }
}

// Preview provider for displaying the AddHistoryView in the SwiftUI canvas
struct AddHistoryView_Previews: PreviewProvider {
  static var previews: some View {
    AddHistoryView(addMode: .constant(true)) // Show the AddHistoryView with add mode active
      .environmentObject(HistoryStore(preview: true)) // Inject a preview instance of HistoryStore
  }
}
