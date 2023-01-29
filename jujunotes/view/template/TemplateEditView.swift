//
//  TemplateEditView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 14.1.2023.
//

import SwiftUI

struct TemplateEditView: View {
    
    @Binding var data: Data
    @State private var newExerciseData: Exercise = Exercise()
    
    var body: some View {
        Form {
            Section(header: Text("Template Info")) {
                TextField("Title", text: $data.title)
            }
            Section(header: Text("Exercises")) {
                ForEach($data.exercises) { exercise in
                    SetsEditView(exercise: exercise, isNewExercise: false)
                }
                .onDelete { indices in
                    data.exercises.remove(atOffsets: indices)
                }
                HStack {
                    ExerciseAddView(exercise: $newExerciseData, data: $data)
                }
            }
        }
    }
}

struct TemplateEditView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateEditView(data: .constant(Template.sampleData[0].data))
    }
}
