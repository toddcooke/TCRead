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
    @State private var ereader = EReader()

    var body: some View {
        VStack {
            NavigationStack {
                NavigationLink {
                    EreaderConfigDetailView()
                } label: {
                    Text("Setup new E-reader")
                }
            }
            // list ereaders
            ForEach(modelData.eReaders) { eReader in
                NavigationLink {
                    EreaderConfigDetailView(ereader: $eReader)
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
    }
}
