//
//  WorkoutsView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 11.11.2022.
//

import SwiftUI

struct WorkoutsView: View {
    @Binding var workouts: [Workout]
    @Binding var selectedTab: Tab
    
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresentingNewWorkoutView = false
    @State private var newWorkoutData = Data()
    let saveAction: ()->Void


    var body: some View {
        List {
            ForEach($workouts) { $workout in
                NavigationLink(destination: WorkoutDetailView(workout: $workout)) {
                    WorkoutCardView(workout: workout)
                }
            }.onDelete(perform: delete)
        }
        .sheet(isPresented: $isPresentingNewWorkoutView) {
            NavigationView {
                WorkoutEditView(data: $newWorkoutData)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Dismiss") {
                                isPresentingNewWorkoutView = false
                                newWorkoutData = Data()
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Add") {
                                let newWorkout = Workout(data: newWorkoutData)
                                workouts.append(newWorkout)
                                isPresentingNewWorkoutView = false
                                newWorkoutData = Data()
                            }
                        }
                    }
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
        .onChange(of: selectedTab) { tab in
            if selectedTab != .workoutsTab { saveAction() }
        }
        .navigationTitle("My workouts")
        .toolbar {
            Button(action: {
                isPresentingNewWorkoutView = true
            }) {
                Image(systemName: "plus")
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        workouts.remove(atOffsets: offsets)
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutsView(workouts: .constant(Workout.sampleData),
                        selectedTab: .constant(Tab.workoutsTab),
                         saveAction: {})
        }
    }
}
