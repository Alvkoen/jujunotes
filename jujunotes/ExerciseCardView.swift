//
//  ExerciseView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 6.12.2022.
//

import SwiftUI

struct ExerciseCardView: View {
    @Binding var exercise: Exercise
    @Binding var data: Workout.Data

    var body: some View {
        VStack(alignment: .leading) {
            Label(exercise.name, systemImage: "dumbbell")
            Spacer()
            HStack {
                Text("Reps: \(exercise.reps)")
                Spacer()
                Text("Sets: \(exercise.sets)")
                Spacer()
                Text("Wgt: \(exercise.weightAsString()) kg")
                Spacer()
            }
        }
        .padding([.top, .bottom])
    }
}

struct ExerciseCardView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = Workout.sampleData[0]
        let exercise = workout.exercises[0]
        ExerciseCardView(exercise: .constant(exercise), data: .constant(workout.data))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
