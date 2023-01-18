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
            HStack() {
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
            HStack() {
                Text("Set")
                    .frame(minWidth: 50, maxWidth: .infinity, alignment: .leading)
                Text("Reps")
                    .frame(maxWidth: .infinity, alignment: .center)
                Text("Wgt")
                    .frame( maxWidth: .infinity, alignment: .trailing)
            }
            .alignmentGuide(HorizontalAlignment.leading) { d in d[HorizontalAlignment.leading] }
            Spacer()
            ForEach(exercise.sets) { set in
                SetViewTableRow(set: set)
            }
        }
        .padding([.top, .bottom])
    }
    
}

struct ExerciseCardView_Previews: PreviewProvider {
    static var previews: some View {
        let exercise = Workout.sampleData[0].exercises[0]
        ExerciseCardView(exercise: .constant(exercise))
            .previewLayout(.fixed(width: 400, height: 90))
    }
}
