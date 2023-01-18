//
//  WorkoutEditView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 11.11.2022.
//

import SwiftUI

struct WorkoutEditView: View {
    
    @Binding var data: Data
    @State private var newExerciseData: Exercise = Exercise()
    
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
                List {
                    ForEach($data.exercises) { exercise in
                        ExerciseCardView(exercise: exercise, isEdit: true).padding(.leading)
                    }.onDelete(perform: delete)
                }
                ExerciseAddView(exercise: $newExerciseData, data: $data).padding(.leading)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        data.exercises.remove(atOffsets: offsets)
    }
}

struct WorkoutEditView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutEditView(data: .constant(Workout.sampleData[0].data))
    }
}


