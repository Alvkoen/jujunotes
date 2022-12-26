//
//  ContentView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 6.12.2022.
//

import SwiftUI

enum Tab: String {
    case workoutsTab
    case templatesTab
    case statsTab
}

struct ContentView: View {
    @State var selectedTab: Tab = .workoutsTab
    @StateObject private var store = WorkoutStore()
    @State private var errorWrapper: ErrorWrapper?
    
    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationView {
                WorkoutsView(workouts: $store.workouts, selectedTab: $selectedTab) {
                    Task {
                        do {
                            try await WorkoutStore.save(workouts: store.workouts)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
                    }
                }
                .task {
                    do {
                        store.workouts = try await WorkoutStore.load()
                    } catch {
                        errorWrapper = ErrorWrapper(error: error, guidance: "Jujunotes will load sample data and continue.")
                    }
                }
                .sheet(item: $errorWrapper, onDismiss: {
                    store.workouts = Workout.sampleData
                }) { wrapper in
                    ErrorView(errorWrapper: wrapper)
                }
            }
            .edgesIgnoringSafeArea(.top)
            .tabItem {
                Label("Workouts", systemImage: "dumbbell")
            }
            .tag(Tab.workoutsTab)
            
            NavigationView {
               TemplatesView()
            }
            .edgesIgnoringSafeArea(.top)
            .tabItem {
                Label("Templates", systemImage: "book")
            }
            .tag(Tab.templatesTab)
            
            NavigationView {
                StatsView()
            }
            .edgesIgnoringSafeArea(.top)
            .tabItem {
                Label("Statistics", systemImage: "chart.line.uptrend.xyaxis")
            }
            .tag(Tab.statsTab)
        }
        .onAppear
        {
            UIPageControl.appearance().currentPageIndicatorTintColor = .black
            UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
