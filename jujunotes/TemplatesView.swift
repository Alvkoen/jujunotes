//
//  TemplatesView.swift
//  jujunotes
//
//  Created by Aleksandra Koen on 26.12.2022.
//

import SwiftUI

struct TemplatesView: View {
    @Binding var templates: [Template]
    @Binding var selectedTab: Tab
    let saveAction: ()->Void
    
    @Environment(\.scenePhase) private var scenePhase

    var body: some View {
        if (templates.isEmpty) {
            Text("No templates available yet")
                .font(.headline)
            Text("Create a template from existing workout")
                .font(.caption)
        }
        else {
            List {
                ForEach($templates) { $template in
                    NavigationLink(destination: TemplateDetailView(template: $template)) {
                        TemplateCardView(template: template)
                    }
                }.onDelete(perform: delete)
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive { saveAction() }
            }
            .onChange(of: selectedTab) { tab in
                if selectedTab != .templatesTab { saveAction() }
            }
            .navigationTitle("My templates")
        }
    }
    
    func delete(at offsets: IndexSet) {
        templates.remove(atOffsets: offsets)
    }
}

struct TemplatesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TemplatesView(templates: .constant(Template.sampleData),
                          selectedTab: .constant(Tab.workoutsTab),
                          saveAction: {}
            )
        }
    }
}
