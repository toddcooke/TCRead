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
        Form {
            TextField("EReader Name", text: $ereader.name)
            Picker("E reader type", selection: $selectedType) {
                Text("Amazon Kindle").tag(EReaderType.KINDLE)
                Text("Kobo").tag(EReaderType.KOBO)
            }
            Button("Create") {
                submit()
            }
                    .alert("Ereader name must not be empty", isPresented: $emptyEreaderName) {
                        Button("OK") {
                            emptyEreaderName = false
                        }
                    }
        }.navigationTitle("Add E-Reader")
    }
}

struct EreaderCreateView_Previews: PreviewProvider {
    static var previews: some View {
        EreaderCreateView(ereader: .constant(EReader.exampleEReader()))
            .environmentObject(ModelData())
    }
}
