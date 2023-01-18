//
//  ExerciseView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 6.12.2022.
//

import SwiftUI

struct ExerciseCardView: View {
    @Binding var exercise: Exercise
    var isEdit = false
    @State private var isPresentingEditView = false
    
    
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
                    }.frame(width: 70, height: 10)
                }
                Spacer()
                if (isEdit == true) {
                    Button("Edit sets") {
                        isPresentingEditView = true
                    }
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
            .sheet(isPresented: $isPresentingEditView) {
                NavigationView {
                    ExercisesEditView(exercise: $exercise)
                        .toolbar {
                            ToolbarItem(placement: .cancellationAction) {
                                Button("Cancel") {
                                    isPresentingEditView = false
                                }
                            }
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isPresentingEditView = false
                                }
                            }
                        }
                }
            }
        }
        .padding([.top, .bottom])
    }
    
}

struct ExerciseCardView_Previews: PreviewProvider {
    static var previews: some View {
        let exercise = Workout.sampleData[0].exercises[1]
        ExerciseCardView(exercise: .constant(exercise), isEdit: true)
            .previewLayout(.fixed(width: 400, height: 90))
    }
}
