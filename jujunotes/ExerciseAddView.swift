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
                                                reps: exercise.reps,
                                                sets: exercise.sets,
                                                weight: exercise.weight)
                data.exercises.append(newExercise)
                exercise = Exercise(name: "", reps: 0, sets: 0, weight: 0)
            }
        }) {
            Image(systemName: "plus.circle.fill")
        }
        .disabled(exercise.name.isEmpty
                  || exercise.reps == 0
                  || exercise.sets == 0
                  || exercise.weight == 0
        )
    }
}

struct ExerciseEditView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = Workout.sampleData[0]
        ExerciseAddView(exercise: .constant(workout.exercises[0]), data: .constant(workout.data))
    }
}
