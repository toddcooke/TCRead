//
// Created by Todd Cooke on 12/13/22.
//

import Foundation

final class ModelData: ObservableObject {
    @Published var eReaders: [EReader] = []

    func addEreader(ereader: EReader) {
        // TODO: save ereader to icloud
        eReaders.append(ereader)
    }
}