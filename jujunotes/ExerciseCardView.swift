//
//  ExerciseView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 6.12.2022.
//

import SwiftUI

struct ExerciseCardView: View {
    @Binding var exercise: Exercise
    
    var body: some View {
        //todo add superset indication
        VStack(alignment: .leading) {
            HStack {
                Label(exercise.name, systemImage: "dumbbell")
                Spacer()
                if (exercise.isSuperset) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.purple)
                        Text("Superset")
                            .foregroundColor(.white)
                    }.frame(width: 80, height: 20)
                }
            }
            Spacer()
            ForEach(exercise.sets) { set in
                HStack {
                    Text("\(set.name)")
                    Spacer()
                    Text("Reps: \(set.reps)")
                    Spacer()
                    Text("Wgt: \(set.weightAsString()) kg")
                    Spacer()
                }
            }
        }
        .padding([.top, .bottom])
    }
}

struct ExerciseCardView_Previews: PreviewProvider {
    static var previews: some View {
        let exercise = Workout.sampleData[0].exercises[1]
        ExerciseCardView(exercise: .constant(exercise))
            .previewLayout(.fixed(width: 400, height: 90))
    }
}
