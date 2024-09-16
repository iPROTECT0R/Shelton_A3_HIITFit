// ExerciseView

// Created by Raymond Shelton on 9/8/24.

// A view that displays an exercise with a video player, start and done buttons, and a rating view. It handles navigation between exercises, tracks completed exercises, and shows a success view upon completing the last exercise.

import SwiftUI

// The view that displays a specific exercise, allowing the user to start, complete, and rate it
struct ExerciseView: View {
  // EnvironmentObject to access shared history data
  @EnvironmentObject var history: HistoryStore
  
  // State variables to control the presentation of modals (sheets) and manage exercise state
  @State private var showHistory = false
  @State private var showSuccess = false
  @State private var timerDone = false
  @State private var showTimer = false
  
  // Binding to the selected tab index for navigation
  @Binding var selectedTab: Int
  
  // Index of the current exercise
  let index: Int
  
  // Computed property to access the current exercise
  var exercise: Exercise {
    Exercise.exercises[index]
  }
  
  // Computed property to check if the current exercise is the last one
  var lastExercise: Bool {
    index + 1 == Exercise.exercises.count
  }

  // Button to start the exercise and show the timer
  var startButton: some View {
    RaisedButton(buttonText: "Start Exercise") {
      showTimer.toggle()
    }
  }

  // Button to mark the exercise as done and navigate to the next exercise or show the success view
  var doneButton: some View {
    Button("Done") {
      history.addDoneExercise(Exercise.exercises[index].exerciseName)
      timerDone = false
      showTimer.toggle()
      if lastExercise {
        showSuccess.toggle()
      } else {
        selectedTab += 1
      }
    }
  }

  var body: some View {
    let exerciseName = Exercise.exercises[index].exerciseName
    GeometryReader { geometry in
      VStack(spacing: 0) {
        // Header view with the exercise name
        HeaderView(
          selectedTab: $selectedTab,
          titleText: exerciseName)
          .padding(.bottom)
        Spacer()
        // Container view to hold the main content
        ContainerView {
          VStack {
            // Video player view for the exercise video
            VideoPlayerView(videoName: exercise.videoName)
              .frame(height: geometry.size.height * 0.35)
              .padding(20)
            // HStack containing the start button and done button with conditional presentation of modals
            HStack(spacing: 150) {
              startButton
                .padding([.leading, .trailing], geometry.size.width * 0.1)
                .sheet(isPresented: $showTimer) {
                  TimerView(
                    timerDone: $timerDone,
                    exerciseName: exerciseName)
                  .onDisappear {
                    // Actions to perform when TimerView disappears
                    if timerDone {
                      history.addDoneExercise(Exercise.exercises[index].exerciseName)
                      timerDone = false
                      if lastExercise {
                        showSuccess.toggle()
                      } else {
                        withAnimation {
                          selectedTab += 1
                        }
                      }
                    }
                  }
                }
                .sheet(isPresented: $showSuccess) {
                  SuccessView(selectedTab: $selectedTab)
                    .presentationDetents([.medium, .large])
                }
            }
            .font(.title3)
            .padding()
            Spacer()
            // Rating view for the exercise
            RatingView(exerciseIndex: index)
              .padding()
            // Button to view history
            historyButton
              .sheet(isPresented: $showHistory) {
                HistoryView(showHistory: $showHistory)
              }
              .padding(.bottom)
          }
        }
        .frame(height: geometry.size.height * 0.8)
      }
    }
  }

  // Button to show history view
  var historyButton: some View {
    Button(
      action: {
        showHistory = true
      }, label: {
        Text("History")
          .fontWeight(.bold)
          .padding([.leading, .trailing], 5)
      })
      .padding(.bottom, 10)
      .buttonStyle(EmbossedButtonStyle())
  }
}

// Preview provider to show a preview of ExerciseView in the SwiftUI canvas
struct ExerciseView_Previews: PreviewProvider {
  static var previews: some View {
    ExerciseView(selectedTab: .constant(0), index: 0)
      .environmentObject(HistoryStore())
  }
}
