//
//  SetEditTableRow.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 17.1.2023.
//

import SwiftUI

struct SetEditTableRow: View {
    @Binding var set: Set
    @Binding var sets: [Set]
    
    var body: some View {
        HStack {
            HStack {
                Spacer()
                TextField("Set name", text: $set.name)
                    .frame(width: 120)
                TextField("Reps", value: $set.reps, formatter: NumberFormatter())
                    .frame(width: 80)
                TextField("Wgt", value: $set.weight, formatter: NumberFormatter())
                    .frame(width: 80)
                Button {
                } label: {
                    Label("", systemImage: "minus.circle.fill")
                }
                Spacer()
            }
            .alignmentGuide(HorizontalAlignment.center) { d in d[HorizontalAlignment.center] }
        }
    }
}


struct SetEditTableRow_Previews: PreviewProvider {
    static var previews: some View {
        let sets = Workout.sampleData[0].exercises[0].sets
        SetEditTableRow(set: .constant(sets[0]), sets: .constant(sets))
    }
}
