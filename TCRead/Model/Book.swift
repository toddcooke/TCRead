//
//  Book.swift
//  TCRead
//
//  Created by Todd Cooke on 12/13/22.
//

import Foundation

struct Book: Encodable, Hashable, Identifiable {
    var id :String {
        textNum
    }

    var textNum: String
    var type: String
    var issued: String
    var title: String
    var language: String
    var authors: String
    var subjects: String
    var locc: String
    var bookshelves: String
    
    static func exampleBook() -> Book {
        Book(textNum: "0", type: "book", issued: Date.now.description,
            title: "Alice in wonderland", language: "en", authors: "Lewis Carrol", subjects: "Fiction", locc: "PR", bookshelves: "Childrens Literature")
    }
}

extension String{
    // Carrol, Lewis -> Lewis Carrol
    func formatAuthor() -> String {
        let components = self.components(separatedBy: ",")
        if components.count >= 2 {
            return "\(components[1]) \(components[0])"
        }
        return self
    }
}
