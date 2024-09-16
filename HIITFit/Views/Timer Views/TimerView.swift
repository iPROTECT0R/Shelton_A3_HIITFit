// TimerView

// Created by Raymond Shelton on 9/8/24.

// A view that displays a countdown timer in a large, rounded font. The timer updates every time the date changes.

import SwiftUI

// A view to display a countdown timer with a large font
struct CountdownView: View {
  // The date that triggers the countdown
  let date: Date
  
  // Binding to the time remaining for the countdown
  @Binding var timeRemaining: Int
  
  // Size of the countdown view
  let size: Double

  var body: some View {
    Text("\(timeRemaining)")
      .font(.system(size: 90, design: .rounded))
      .fontWeight(.heavy)
      .frame(
        minWidth: 180,
        maxWidth: 200,
        minHeight: 180,
        maxHeight: 200)
      .padding()
      // Update the time remaining when the date changes
      .onChange(of: date) { _ in
        timeRemaining -= 1
      }
  }
}


// The view that manages and displays a countdown timer for an exercise
struct TimerView: View {
  // Environment value to dismiss the view
  @Environment(\.dismiss) var dismiss
  
  // State variable to keep track of the remaining time
  @State private var timeRemaining: Int = 3
  
  // Binding to the timer completion state
  @Binding var timerDone: Bool
  
  // Name of the exercise being timed
  let exerciseName: String

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        // Background color with gradient
        Color("background")
          .ignoresSafeArea()
        
        // Gradient circle overlay
        let gradient = Gradient(
          stops: [
            Gradient.Stop(color: Color("gradient-top"), location: 0.7),
            Gradient.Stop(color: Color("gradient-bottom"), location: 1.1)
          ])
        Circle()
          .foregroundStyle(gradient)
          .position(
            x: geometry.size.width * 0.5,
            y: -geometry.size.width * 0.2)
        
        // Title text
        VStack {
          Text(exerciseName)
            .font(.largeTitle)
            .fontWeight(.black)
            .foregroundColor(.white)
            .padding(.top, 20)
          Spacer()
        }
        
        // Countdown timer using TimelineView
        TimelineView(
          .animation(
            minimumInterval: 1.0,
            paused: timeRemaining <= 0)) { context in
              IndentView {
                CountdownView(
                  date: context.date,
                  timeRemaining: $timeRemaining,
                  size: geometry.size.width)
              }
        }
        .onChange(of: timeRemaining) { _ in
          // Mark the timer as done when time runs out
          if timeRemaining < 1 {
            timerDone = true
          }
        }
        
        // Done button that appears when the timer is finished
        VStack {
          Spacer()
          RaisedButton(buttonText: "Done") {
            dismiss()
          }
          .opacity(timerDone ? 1 : 0)
          .padding([.leading, .trailing], 30)
          .padding(.bottom, 60)
          .disabled(!timerDone)
        }
      }
    }
  }
}

// Preview provider to show a preview of TimerView in the SwiftUI canvas
struct TimerView_Previews: PreviewProvider {
  static var previews: some View {
    TimerView(
      timerDone: .constant(false),
      exerciseName: "Step Up")
  }
}
