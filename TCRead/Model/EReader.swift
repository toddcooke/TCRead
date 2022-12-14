//
// Created by Todd Cooke on 12/13/22.
//

import Foundation

enum EReaderType {
    case KINDLE
    case KOBO
}

struct EReader: Identifiable {
    var id: Int = UUID().hashValue
    var name: String
    var ereaderType: EReaderType
}