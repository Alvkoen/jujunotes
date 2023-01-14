//
//  TemplateDetailView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 6.1.2023.
//

import SwiftUI

struct TemplateDetailView: View {
    
    @Binding var template: Template
    @State private var data = Template.Data()
    @State private var isPresentingEditView = false
    @State private var isEditingOrder = false

    
    var body: some View {
        List {
            Section(header: Text("Template info")) {
                HStack() {
                    Label("Title", systemImage: "book")
                    Spacer()
                    Text("\(template.title)")
                }
            }
            Section(header: Text("Exercises")) {
                if (template.exercises.isEmpty) {
                    Text("No exercises added yet")
                        .font(.caption)
                } else {
                    ForEach($template.exercises) { exercise in
                        ExerciseCardView(exercise: exercise)
                    }
                    .onDelete(perform: delete)
                    .onMove(perform: move)
                    .onLongPressGesture {
                        withAnimation {
                            self.isEditingOrder = true
                        }
                    }
                }
            }
        }
        .navigationTitle(template.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = template.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                TemplateEditView(data: $data)
                    .navigationTitle(template.title)
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Done") {
                                isPresentingEditView = false
                                template.update(from: data)
                            }
                        }
                    }
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        template.exercises.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        template.exercises.move(fromOffsets: source, toOffset: destination)
        withAnimation {
            isEditingOrder = false
        }
    }
}

struct TemplateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TemplateDetailView(template: .constant(Template.sampleData[0]))
        }
    }
}
