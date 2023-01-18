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
            TextField("Exercise name", text: $exercise.name).font(Font.title2).padding()
            List {
                HStack() {
                    Text("Set")
                        .frame(width: 100)
                    Text("Reps")
                        .frame(width: 100)
                    Text("Wgt")
                        .frame(width: 100)
                    Spacer()
                }
                .alignmentGuide(HorizontalAlignment.center) { d in d[HorizontalAlignment.center] }
                ForEach($exercise.sets) { set in
                    SetEditTableRow(set: set)
                }.onDelete(perform: delete)
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        exercise.sets.remove(atOffsets: offsets)
    }
    
}

struct ExercisesEditView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = Workout.sampleData[0]
        ExercisesEditView(exercise: .constant(workout.exercises[0]))
    }
}
