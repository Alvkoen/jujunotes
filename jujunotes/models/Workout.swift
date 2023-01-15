//
//  Workout.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 14.1.2023.
//

import Foundation

struct Workout: Identifiable {
    let id: UUID
    var title: String
    var date: Date
    var exercises: [Exercise]
    
    init(id: UUID = UUID(), title: String, date: Date, exercises: [Exercise]) {
        self.id = id
        self.title = title
        self.date = date
        self.exercises = exercises
    }
}

extension Workout: Codable {
    
    //Data object from Workout
    var data: Data {
        Data(title: title, date: date, exercises: exercises)
    }
    
    //Template object from Workout
    var template: Template {
        return Template(id: UUID(), title: title, exercises: exercises)
    }
    
    //Workout constructor from data
    init(data: Data) {
        id = UUID()
        title = data.title
        date = data.date
        exercises = data.exercises
    }
    
    func dateAsString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.string(from: self.date)
    }
    
    mutating func update(from data: Data) {
        title = data.title
        date = data.date
        exercises = data.exercises
    }
    
}

let today: Date = Date.now

extension Workout {
    
    static let sampleData: [Workout] =
    [
        Workout(title: "Lower body", date: Date.now, exercises: [
            Exercise(name: "Leg press", order: 0, isSuperset: false, sets: [
                Set(name: "Set 1", reps: 10, weight: 80.5, order: 0),
                Set(name: "Set 2", reps: 10, weight: 30, order: 1)
            ]),
            Exercise(name: "Leg superset", order: 0, isSuperset: true, sets: [
                Set(name: "Leg extenstion", reps: 10, weight: 80.5, order: 0),
                Set(name: "Leg curl", reps: 10, weight: 30, order: 1)
            ])
        ]),
        Workout(title: "Upper body",
                date: Calendar.current.date(byAdding: .day, value: 1, to: today)!,
                exercises: []),
    ]
}

