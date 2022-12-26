//
//  ExercisesEditView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 11.12.2022.
//

import SwiftUI

struct ExercisesEditView: View {
    
    @Binding var exercise: Workout.Exercise

    
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
    }
}

struct ExercisesEditView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = Workout.sampleData[0]
        ExercisesEditView(exercise: .constant(workout.exercises[0]))
    }
}
