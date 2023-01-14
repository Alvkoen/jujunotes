//
//  WorkoutStore.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 15.11.2022.
//

import Foundation

//Eventually this data should be stored in a database and fetched from backend
class WorkoutStore: ObservableObject {
    @Published var workouts: [Workout] = []
    @Published var templates: [Template] = []
    
    private static func fileURL(fileName: String) throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
        .appendingPathComponent(fileName)
    }
    
    static func loadWorkout() async throws -> [Workout] {
        try await withCheckedThrowingContinuation { continuation in
            loadWorkout { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let workoutsSaved):
                    let sortedWorkouts = workoutsSaved.sorted(by: { $0.date.compare($1.date) == .orderedDescending })
                    continuation.resume(returning: sortedWorkouts)
                }
            }
        }
    }
    
    static func loadWorkout(completion: @escaping (Result<[Workout], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL(fileName: "jujuworkouts.data")
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let workouts = try JSONDecoder().decode([Workout].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(workouts))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func saveWorkout(workouts: [Workout]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            saveWorkout(workouts: workouts) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let workoutsSaved):
                    continuation.resume(returning: workoutsSaved)
                }
            }
        }
    }
    
    static func saveWorkout(workouts: [Workout], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(workouts)
                let outfile = try fileURL(fileName: "jujuworkouts.data")
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(workouts.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func loadTemplates() async throws -> [Template] {
        try await withCheckedThrowingContinuation { continuation in
            loadTemplates { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let templatesSaved):
                    continuation.resume(returning: templatesSaved)
                }
            }
        }
    }
    
    static func loadTemplates(completion: @escaping (Result<[Template], Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL(fileName: "jujutemplates.data")
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success([]))
                    }
                    return
                }
                let templates = try JSONDecoder().decode([Template].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(templates))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    @discardableResult
    static func saveTemplates(templates: [Template]) async throws -> Int {
        try await withCheckedThrowingContinuation { continuation in
            saveTemplates(templates: templates) { result in
                switch result {
                case .failure(let error):
                    continuation.resume(throwing: error)
                case .success(let templatesSaved):
                    continuation.resume(returning: templatesSaved)
                }
            }
        }
    }
    
    static func saveTemplates(templates: [Template], completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(templates)
                let outfile = try fileURL(fileName: "jujutemplates.data")
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(templates.count))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}
