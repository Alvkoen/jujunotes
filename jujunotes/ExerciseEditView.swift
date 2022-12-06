//
//  ExerciseEditView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 6.12.2022.
//

import SwiftUI

struct ExerciseEditView: View {
    @Binding var exercise: Workout.Exercise
    @Binding var data: Workout.Data
    
    var body: some View {
        VStack {
            TextField("New Exercise name", text: $exercise.name)
            HStack {
                Group {
                    Text("Reps")
                    TextField("Reps", value: $exercise.reps, formatter: NumberFormatter())
                }
                Spacer()
                Group {
                    Text("Sets")
                    TextField("Sets", value: $exercise.sets, formatter: NumberFormatter())
                }
                Spacer()
                Group {
                    Text("Wgt")
                    TextField("Wgt", value: $exercise.weight, formatter: NumberFormatter())
                }
                Spacer()
            }
        }
        Button(action: {
            withAnimation {
                let newExercise = Workout.Exercise(id: exercise.id,
                                                name: exercise.name,
                                                reps: exercise.reps,
                                                sets: exercise.sets,
                                                weight: exercise.weight)
                if let index = data.exercises.firstIndex(where: {$0.id == exercise.id}) {
                    data.exercises[index] = newExercise
                } else {
                    data.exercises.append(newExercise)
                    exercise = Workout.Exercise(name: "", reps: 0, sets: 0, weight: 0)
                }
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
        ExerciseEditView(exercise: .constant(workout.exercises[0]), data: .constant(workout.data))
    }
}
