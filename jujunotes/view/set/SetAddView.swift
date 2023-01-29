//
//  SetAddView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 29.1.2023.
//

import SwiftUI

struct SetAddView: View {
    @Binding var set: Set
    @Binding var exercise: Exercise
    
    var body: some View {
        VStack {
            SetEditTableRow(set: $set)
            
            Button(action: {
                withAnimation {
                    let newSet = Set(id: set.id,
                                     name: set.name,
                                     reps: set.reps,
                                     weight: set.weight,
                                     order: set.order
                    )
                    exercise.sets.append(newSet)
                    set = Set.init()
                }
            }) {
                Label("Add set", systemImage: "plus.circle.fill")
            }
            .padding(.horizontal)
            .disabled(!setIsFilled())
        }
    }
    
    func setIsFilled() -> Bool {
        if ($set.name.wrappedValue.isEmpty ||
            $set.reps.wrappedValue == 0 ||
            $set.weight.wrappedValue == 0)
        {
            return false
        }
        return true
    }
}



struct SetAddView_Previews: PreviewProvider {
    static var previews: some View {
        SetAddView(set: .constant(Set.init()), exercise: .constant(Exercise.init()))
    }
}
