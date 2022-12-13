//
// Created by Todd Cooke on 12/13/22.
//

import Foundation
import SwiftUI

struct EreaderConfigDetailView: View {
    @Binding var ereader: EReader
    var body: some View {
        VStack {
            // If ereader == nil:
            Text("EReader name:").bold()
            TextField("EReader Name", text: $ereader.name)
        }
    }
}