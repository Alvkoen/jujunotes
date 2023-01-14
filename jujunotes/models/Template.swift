//
//  Template.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 14.1.2023.
//

import Foundation

struct Template: Identifiable {
    let id: UUID
    var title: String
    var exercises: [Exercise]
    
    init(id: UUID = UUID(), title: String, exercises: [Exercise]) {
        self.id = id
        self.title = title
        self.exercises = exercises
    }
}

extension Template: Codable {
    //Data object from Template
    var data: Data {
        Data(title: title, exercises: exercises)
    }
    
    //Template object from Workout
    var template: Template {
        return Template(id: UUID(), title: title, exercises: exercises)
    }
    
    //Workout constructor from data
    init(data: Data) {
        id = UUID()
        title = data.title
        exercises = data.exercises
    }
    
    mutating func update(from data: Data) {
        title = data.title
        exercises = data.exercises
    }
}

extension Template {
    static let sampleData: [Template] =
    [
        Template(title: "Lower body", exercises: [
            Exercise(name: "Leg press", reps: 10, sets: 3, weight: 80.5),
            Exercise(name: "Leg extenstion", reps: 10, sets: 3, weight: 30)
        ]),
        Template(title: "Upper body",
                 exercises: [])
    ]
}
