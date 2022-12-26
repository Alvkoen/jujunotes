//
//  Workout.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 11.11.2022.
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

struct Exercise: Identifiable, Codable {
    let id: UUID
    var name: String
    var reps: Int
    var sets: Int
    var weight: Double
    
    init(id: UUID = UUID(), name: String, reps: Int, sets: Int, weight: Double) {
        self.id = id
        self.name = name
        self.reps = reps
        self.sets = sets
        self.weight = weight
    }
    
    init() {
        self.id = UUID()
        self.name = ""
        self.reps = 0
        self.sets = 0
        self.weight = 0
    }
    
    func weightAsString() -> String {
        return String(format: "%g", self.weight)
    }
}

extension Workout: Codable {
    struct Data {
        var title: String = ""
        var date: Date = Date.now
        var exercises: [Exercise] = []
    }
    
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
            Exercise(name: "Leg press", reps: 10, sets: 3, weight: 80.5),
            Exercise(name: "Leg extenstion", reps: 10, sets: 3, weight: 30)
        ]),
        Workout(title: "Upper body",
                date: Calendar.current.date(byAdding: .day, value: 1, to: today)!,
                exercises: []),
        Workout(title: "A very long title. It's so huuuuuuge - who would call a workout like this?",
                date: Calendar.current.date(byAdding: .day, value: 2, to: today)!,
                exercises: [])
    ]
}
