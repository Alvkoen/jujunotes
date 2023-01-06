//
//  TemplateDetailView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 6.1.2023.
//

import SwiftUI

struct TemplateDetailView: View {
    
    @Binding var template: Template
    
    var body: some View {
        List {
            
        }
        .navigationTitle(template.title)

        Text(template.title)
    }
}

struct TemplateDetailView_Previews: PreviewProvider {
    static var previews: some View {
        TemplateDetailView(template: .constant(Template.sampleData[0]))
    }
}
