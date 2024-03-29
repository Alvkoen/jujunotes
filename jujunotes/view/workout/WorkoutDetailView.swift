//
//  WorkoutDetailView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 11.11.2022.
//

import SwiftUI

struct WorkoutDetailView: View {
    
    @Binding var workout: Workout
    @Binding var templates: [Template]
    @State private var data = Data()
    @State private var isPresentingEditView = false
    @State private var isEditingOrder = false
    let saveAction: ()->Void
    
    
    var body: some View {
        List {
            Section(header: Text("Workout info")) {
                HStack() {
                    Label("Title", systemImage: "book")
                    Spacer()
                    Text("\(workout.title)")
                }
                HStack {
                    Label("Date", systemImage: "clock")
                    Spacer()
                    Text("\(workout.dateAsString())")
                }
            }
            Section(header: Text("Exercises")) {
                if (workout.exercises.isEmpty) {
                    Text("No exercises added yet")
                        .font(.caption)
                } else {
                    ForEach($workout.exercises) { exercise in
                        ExerciseCardView(exercise: exercise, isEdit: false)
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
            Section(header: Text("Actions")) {
                Button {
                    templateFromWorkout()
                } label: {
                    Label("Save as template", systemImage: "square.and.arrow.down")
                }
            }
        }
        .navigationTitle(workout.title)
        .toolbar {
            Button("Edit") {
                isPresentingEditView = true
                data = workout.data
            }
        }
        .sheet(isPresented: $isPresentingEditView) {
            NavigationView {
                GeometryReader { geometry in
                    ScrollView {
                        WorkoutEditView(data: $data)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .navigationTitle(workout.title)
                            .toolbar {
                                ToolbarItem(placement: .cancellationAction) {
                                    Button("Cancel") {
                                        isPresentingEditView = false
                                    }
                                }
                                ToolbarItem(placement: .confirmationAction) {
                                    Button("Done") {
                                        isPresentingEditView = false
                                        workout.update(from: data)
                                    }
                                }
                            }
                    }
                }
                .navigationBarTitle("Sheet")
            }
        }
    }
    
    func delete(at offsets: IndexSet) {
        workout.exercises.remove(atOffsets: offsets)
    }
    
    func move(from source: IndexSet, to destination: Int) {
        workout.exercises.move(fromOffsets: source, toOffset: destination)
        withAnimation {
            isEditingOrder = false
        }
    }
    
    func templateFromWorkout() {
        let template = Template.init(data: workout.data)
        templates.append(template)
        saveAction()
    }
}

struct WorkoutDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WorkoutDetailView(workout: .constant(Workout.sampleData[0]),
                              templates: .constant(Template.sampleData),
                              saveAction: {})
        }
    }
    
}
