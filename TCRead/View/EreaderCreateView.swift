//
// Created by Todd Cooke on 12/14/22.
//

import Foundation
import SwiftUI

struct EreaderCreateView: View {
    @Binding var ereader: EReader
    @EnvironmentObject var modelData: ModelData
    @Environment(\.dismiss) var dismiss
    @State private var emptyEreaderName = false
    @State private var selectedType: EReaderType = .KINDLE

    func submit() {
        if ereader.name.isEmpty {
            emptyEreaderName = true
        } else {
            modelData.addEreader(ereader: ereader)
            dismiss()
        }
    }

    var body: some View {
        List {
            HStack {
                Text("Ereader name").bold()
                Divider()
                TextField("EReader Name", text: $ereader.name)
            }
            HStack {
                Text("Ereader type").bold()
                Divider()
                Picker("E reader type", selection: $selectedType) {
                    Text("Amazon Kindle").tag(EReaderType.KINDLE)
                    Text("Kobo").tag(EReaderType.KOBO)
                }
            }
            Button("Create") {
                submit()
            }
                    .alert("Ereader name must not be empty", isPresented: $emptyEreaderName) {
                        Button("OK") {
                            emptyEreaderName = false
                        }
                    }
        }
                .padding()
    }
}