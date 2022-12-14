//
// Created by Todd Cooke on 12/13/22.
//

import Foundation
import SwiftUI

// add ereader button

// list of ereaders
//  -> ereader config detail view

struct EreaderConfigView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var ereaderNew = EReader(name: "", ereaderType: EReaderType.KINDLE)
    @State private var showingSheet = false
    var body: some View {
        VStack {
            Button("Set up new E-Reader") {
                showingSheet.toggle()
            }
                    .sheet(isPresented: $showingSheet) {
                        EreaderCreateView(ereader: $ereaderNew)
                    }
            ForEach(modelData.eReaders) { eReader in
                NavigationLink {
                    EreaderConfigDetailView(ereader: eReader)
                } label: {
                    Text(eReader.name)
                }
            }
        }
    }
}

struct EreaderConfigView_Previews: PreviewProvider {
    static var previews: some View {
        EreaderConfigView()
            .environmentObject(ModelData())
    }
}
