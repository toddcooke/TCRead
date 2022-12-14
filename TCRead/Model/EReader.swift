//
// Created by Todd Cooke on 12/13/22.
//

import Foundation

enum EReaderType: CustomStringConvertible {
    var description: String {
        switch self {
        case .KINDLE: return "Kindle"
        case .KOBO: return "Kobo"
        }
    }

    case KINDLE
    case KOBO
}

struct EReader: Identifiable {
    var id: Int = UUID().hashValue
    var name: String
    var ereaderType: EReaderType
    
    static func exampleEReader()-> EReader{
        EReader(name: "my kindle", ereaderType: EReaderType.KINDLE)
    }
}
