//
//  ExerciseEditView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 6.12.2022.
//

import SwiftUI

struct ExerciseAddView: View {
    @Binding var exercise: Exercise
    @Binding var data: Data
    
    var body: some View {
        ExercisesEditView(exercise: $exercise)
        
        Button(action: {
            withAnimation {
                let newExercise = Exercise(id: exercise.id,
                                           name: exercise.name,
                                           order: exercise.order,
                                           isSuperset: exercise.isSuperset,
                                           sets: exercise.sets)
                data.exercises.append(newExercise)
                exercise = Exercise.init()
            }
        }) {
            Image(systemName: "plus.circle.fill")
        }
        .disabled(exercise.name.isEmpty || !setsAreFilled(sets: exercise.sets))
    }
    
    func setsAreFilled(sets: [Set]) -> Bool {
        for set in sets {
            if (set.name.isEmpty ||
                set.reps == 0 ||
                set.weight == 0)
            {
               return false
            }
        }
        return true
    }
}

struct ExerciseEditView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = Workout.sampleData[0]
        ExerciseAddView(exercise: .constant(workout.exercises[0]), data: .constant(workout.data))
    }
}
