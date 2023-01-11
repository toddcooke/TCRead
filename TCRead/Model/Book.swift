//
//  Book.swift
//  TCRead
//
//  Created by Todd Cooke on 12/13/22.
//

import Foundation

struct Book: Encodable, Hashable, Identifiable {
    var id: String {
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
        // Do nothing for now since it's confusing if not all authors are listed
//        let components = self.components(separatedBy: ",")
//        if components.count >= 2 {
//            return "\(components[1]) \(components[0])"
//        }
        return self
    }
}

// Todo: either get this working or remove it
//extension String {
//    // Carrol, Lewis -> Lewis Carrol
//    // Van der Veldt, James Herman, 1893- -> James Herman Van der Veldt
//    // Ollier, Edmund, 1827-1886; Wilson, Robert, 1846-1893 -> Edmund Ollier, Robert Wilson
//    func formatAuthor() -> String {
//        var components = self.components(separatedBy: ",").map {
//            $0.trimmingCharacters(in: .whitespaces)
//        }
//        .map { s in
//            // Remove non letter characters
//            var result = s
//            result.unicodeScalars.removeAll { element in
//                !CharacterSet.letters.contains(element)
//            }
//            return result
//        }
//        .filter { (t: String) in
//            !t.isEmpty
//        }
//        guard components.count > 1 else {
//            return self
//        }
//        var i = 0
//        var highestSwapped = -1
//        while i < components.count {
//            // if curr ! name: remove [i]th
//            // if highestSwapped != i -1: swap curr,prev; highestSwapped = i
//            // i++
//            let curr = components[i]
//            guard isName(curr) else {
//                components.remove(at: i)
//                i += 1
//                continue
//            }
//            guard i > 0 else {
//                i += 1
//                continue
//            }
//            let prev = components[i - 1]
//            if highestSwapped != i - 1 {
//                components[i] = prev
//                components[i - 1] = curr
//                if i != components.count - 1 {
//                    components.insert(",", at: i + 1)
//                    highestSwapped = i + 1
//                    i += 1
//                }
//            }
//            i += 1
//        }
//        return components.joined(separator: " ")
//    }
//
//    private func isName(_ current: String) -> Bool {
////        "".allSatisfy { c in CharacterSet.letters.contains(c) }
//        print("testing name of " + current)
////        var result = !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
////        return result
//
//        var result = current.unicodeScalars.allSatisfy { element in
//            CharacterSet.letters.contains(element)
//        }
//        print("result is " + result.description)
//        return result
////        return CharacterSet.letters.contains(current)
//    }
//}
