//
//  WorkoutEditView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 11.11.2022.
//

import SwiftUI

struct WorkoutEditView: View {
    
    @Binding var data: Workout.Data
    @State private var newExerciseData: Workout.Exercise = Workout.Exercise()
    
    var body: some View {
        Form {
            Section(header: Text("Workout Info")) {
                TextField("Title", text: $data.title)
                DatePicker("Workout date",
                           selection: $data.date,
                           displayedComponents:  [.date]
                )
            }
            Section(header: Text("Exercises")) {
                ForEach($data.exercises) { exercise in
                    ExercisesEditView(exercise: exercise)
                }
                .onDelete { indices in
                    data.exercises.remove(atOffsets: indices)
                }
                HStack {
                    ExerciseAddView(exercise: $newExerciseData, data: $data)
                }
            }
        }
    }
}

struct WorkoutEditView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutEditView(data: .constant(Workout.sampleData[0].data))
    }
}


