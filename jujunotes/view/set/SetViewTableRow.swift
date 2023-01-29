//
//  ExerciseTableRow.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 17.1.2023.
//

import SwiftUI


struct SetViewTableRow: View {
    var set: Set
    var body: some View {
        HStack {
            Text("\(set.name)")
                .frame(minWidth: 1, maxWidth: .infinity, alignment: .leading)
            Text("\(set.reps)")
                .frame(minWidth: 5, maxWidth: .infinity, alignment: .center)
            Text("\(set.weightAsString()) kg")
                .frame(minWidth: 5, maxWidth: .infinity, alignment: .trailing)
        }
        .alignmentGuide(HorizontalAlignment.leading) { d in d[HorizontalAlignment.leading] }
//        .padding(.leading)
    }
}

struct ExerciseTableRow_Previews: PreviewProvider {
    static var previews: some View {
        SetViewTableRow(set: Workout.sampleData[0].exercises[0].sets[0])
    }
}
