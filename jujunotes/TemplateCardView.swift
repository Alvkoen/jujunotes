//
//  TemplateCardView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 6.1.2023.
//

import SwiftUI

struct TemplateCardView: View {
    let template: Template
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Label(template.title, systemImage: "book")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityAddTraits(.isHeader)
            }
            
        }
        .padding()
        
    }
}

struct TemplateCardView_Previews: PreviewProvider {
    static var template = Template.sampleData[1]
    static var previews: some View {
        TemplateCardView(template: template)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
