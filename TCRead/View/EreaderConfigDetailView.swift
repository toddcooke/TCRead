//
// Created by Todd Cooke on 12/13/22.
//

import Foundation
import SwiftUI

struct EreaderConfigDetailView: View {
    var ereader: EReader
    var body: some View {
        VStack {
            Text("EReader name:" + ereader.name).bold()
            Text("EReader type:" + ereader.ereaderType.description).bold()
        }
    }
}

struct EreaderConfigDetailView_Previews: PreviewProvider {
    static var previews: some View {
        EreaderConfigDetailView(ereader: EReader.exampleEReader())
            .environmentObject(ModelData())
    }
}
