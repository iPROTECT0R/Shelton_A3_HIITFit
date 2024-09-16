// WelcomeView

// Created by Raymond Shelton on 9/8/24.

// A view that greets users and provides options to view history and reports. It includes a header, a container for welcome content, and buttons for interacting with history and reports. The view utilizes GeometryReader to adjust layout based on screen size and presents sheets for additional views.

import SwiftUI

// The view that welcomes the user and provides navigation options
struct WelcomeView: View {
  // EnvironmentObject to access shared history data
  @EnvironmentObject var historyStore: HistoryStore
  
  // State variables to control the presentation of modals (sheets)
  @State private var showHistory = false
  @State private var showReports = false
  
  // Binding to the selected tab index for navigation
  @Binding var selectedTab: Int

  var body: some View {
    // GeometryReader to adapt layout based on available space
    GeometryReader { geometry in
      VStack {
        // Header view with a title
        HeaderView(
          selectedTab: $selectedTab,
          titleText: "Welcome")
        
        Spacer()
        
        // Container view to hold the main content
        ContainerView {
          // ViewThatFits adapts layout based on available space
          ViewThatFits {
            VStack {
              // Static elements like images and text
              WelcomeView.images
              WelcomeView.welcomeText
              
              // Button to start
              getStartedButton
              
              Spacer()
              
              // HStack containing buttons for history and reports
              buttonHStack
            }
            VStack {
              WelcomeView.welcomeText
              getStartedButton
              Spacer()
              buttonHStack
            }
          }
        }
        .frame(height: geometry.size.height * 0.8) // Set height to 80% of available height
      }
      // Sheets presented for history and reports
      .sheet(isPresented: $showHistory) {
        HistoryView(showHistory: $showHistory)
      }
      .sheet(isPresented: $showReports) {
        BarChartWeekView()
      }
    }
  }

  // Button to navigate to the main content
  var getStartedButton: some View {
    RaisedButton(buttonText: "Get Started") {
      withAnimation {
        selectedTab = 0
      }
    }
    .padding()
  }

  // HStack containing history and reports buttons
  var buttonHStack: some View {
    HStack(spacing: 40) {
      historyButton
      reportsButton
    }
    .padding(10)
  }

  // Button to show history view
  var historyButton: some View {
    Button(
      action: {
        showHistory = true
      }, label: {
        Text("History")
          .fontWeight(.bold)
      })
      .buttonStyle(EmbossedButtonStyle())
  }

  // Button to show reports view
  var reportsButton: some View {
    Button(
      action: {
        showReports = true
      }, label: {
        Text("Reports")
          .fontWeight(.bold)
      })
      .buttonStyle(EmbossedButtonStyle())
  }
}

// Preview provider to show a preview of WelcomeView in the SwiftUI canvas
struct WelcomeView_Previews: PreviewProvider {
  static var previews: some View {
    WelcomeView(selectedTab: .constant(9))
      .environmentObject(HistoryStore(preview: true))
  }
}
