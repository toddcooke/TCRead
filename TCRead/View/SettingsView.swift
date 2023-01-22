//
//  SettingsView.swift
//  TCRead
//
//  Created by Todd Cooke on 1/20/23.
//

import Foundation
import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        Form{
            NavigationStack {
                VStack {
                    NavigationLink("Update kindle email") {
                        EmailPromptView()
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .padding()
        .frame(width: 400)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
