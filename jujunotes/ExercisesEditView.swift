//
//  ExercisesEditView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 11.12.2022.
//

import SwiftUI

struct ExercisesEditView: View {
    
    @Binding var exercise: Exercise
    
    var body: some View {
        VStack {
            Group {
                TextField("Exercise name", text: $exercise.name)
            }
            ForEach($exercise.sets) { set in
                HStack {
                    Group {
                        TextField("Set name", text: set.name)
                    }
                    Spacer()
                    Group {
                        Text("Reps")
                        TextField("Reps", value: set.reps, formatter: NumberFormatter())
                    }
                    Spacer()
                    Group {
                        Text("Wgt")
                        TextField("Wgt", value: set.weight, formatter: NumberFormatter())
                    }
                    Spacer()
                    //todo add set copy button
                }
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
