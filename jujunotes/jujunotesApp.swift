//
//  jujunotesApp.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 6.12.2022.
//

import os
import SwiftUI

@main
struct jujunotesApp: App {
    @StateObject private var store = WorkoutStore()
    @State private var errorWrapper: ErrorWrapper?

    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                WorkoutsView(workouts: $store.workouts) {
                    Task {
                        do {
                            try await WorkoutStore.save(workouts: store.workouts)
                        } catch {
                            errorWrapper = ErrorWrapper(error: error, guidance: "Try again later.")
                        }
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
    }
}
